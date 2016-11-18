Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6743 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753576AbcKRSqG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 13:46:06 -0500
Date: Sat, 19 Nov 2016 02:45:18 +0800
From: kbuild test robot <lkp@intel.com>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: kbuild-all@01.org, mb@lightnvm.io, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH 16/20] lightnvm: eliminate nvm_block abstraction on mm
Message-ID: <201611190248.uxboDLlC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479480222-18790-17-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Javier,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9-rc5]
[cannot apply to next-20161117]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Javier-Gonz-lez/lightnvm-simplify-media-manager/20161119-005946


coccinelle warnings: (new ones prefixed by >>)

>> drivers/lightnvm/rrpc.c:1123:13-19: ERROR: rlun is NULL but dereferenced.
--
>> drivers/lightnvm/rrpc.c:1293:7-11: ERROR: reference preceded by free on line 1273

vim +1123 drivers/lightnvm/rrpc.c

  1117			raddr[mod].addr = slba + i;
  1118	
  1119			gaddr = rrpc_ppa_to_gaddr(dev, pba);
  1120			rlun = rrpc_ppa_to_lun(rrpc, gaddr);
  1121			if (!rlun) {
  1122				pr_err("rrpc: unmapped lun %d l2p corruption\n",
> 1123								rlun->parent->id);
  1124				return -EINVAL;
  1125			}
  1126	
  1127			rblk = &rlun->blocks[gaddr.g.blk];
  1128			if (!rblk->state) {
  1129				/* at this point, we don't know anything about the
  1130				 * block. It's up to the FTL on top to re-etablish the
  1131				 * block state. The block is assumed to be open.
  1132				 */
  1133				list_move_tail(&rblk->list, &rlun->used_list);
  1134				rblk->state = NVM_BLK_ST_TGT;
  1135				rlun->nr_free_blocks--;
  1136			}
  1137		}
  1138	
  1139		return 0;
  1140	}
  1141	
  1142	static int rrpc_map_init(struct rrpc *rrpc)
  1143	{
  1144		struct nvm_tgt_dev *dev = rrpc->dev;
  1145		sector_t i;
  1146		int ret;
  1147	
  1148		rrpc->trans_map = vzalloc(sizeof(struct rrpc_addr) * rrpc->nr_sects);
  1149		if (!rrpc->trans_map)
  1150			return -ENOMEM;
  1151	
  1152		rrpc->rev_trans_map = vmalloc(sizeof(struct rrpc_rev_addr)
  1153								* rrpc->nr_sects);
  1154		if (!rrpc->rev_trans_map)
  1155			return -ENOMEM;
  1156	
  1157		for (i = 0; i < rrpc->nr_sects; i++) {
  1158			struct rrpc_addr *p = &rrpc->trans_map[i];
  1159			struct rrpc_rev_addr *r = &rrpc->rev_trans_map[i];
  1160	
  1161			p->addr = ADDR_EMPTY;
  1162			r->addr = ADDR_EMPTY;
  1163		}
  1164	
  1165		if (!dev->ops->get_l2p_tbl)
  1166			return 0;
  1167	
  1168		/* Bring up the mapping table from device */
  1169		ret = dev->ops->get_l2p_tbl(dev->parent, rrpc->soffset, rrpc->nr_sects,
  1170						rrpc_l2p_update, rrpc);
  1171		if (ret) {
  1172			pr_err("nvm: rrpc: could not read L2P table.\n");
  1173			return -EINVAL;
  1174		}
  1175	
  1176		return 0;
  1177	}
  1178	
  1179	/* Minimum pages needed within a lun */
  1180	#define PAGE_POOL_SIZE 16
  1181	#define ADDR_POOL_SIZE 64
  1182	
  1183	static int rrpc_core_init(struct rrpc *rrpc)
  1184	{
  1185		down_write(&rrpc_lock);
  1186		if (!rrpc_gcb_cache) {
  1187			rrpc_gcb_cache = kmem_cache_create("rrpc_gcb",
  1188					sizeof(struct rrpc_block_gc), 0, 0, NULL);
  1189			if (!rrpc_gcb_cache) {
  1190				up_write(&rrpc_lock);
  1191				return -ENOMEM;
  1192			}
  1193	
  1194			rrpc_rq_cache = kmem_cache_create("rrpc_rq",
  1195					sizeof(struct nvm_rq) + sizeof(struct rrpc_rq),
  1196					0, 0, NULL);
  1197			if (!rrpc_rq_cache) {
  1198				kmem_cache_destroy(rrpc_gcb_cache);
  1199				up_write(&rrpc_lock);
  1200				return -ENOMEM;
  1201			}
  1202		}
  1203		up_write(&rrpc_lock);
  1204	
  1205		rrpc->page_pool = mempool_create_page_pool(PAGE_POOL_SIZE, 0);
  1206		if (!rrpc->page_pool)
  1207			return -ENOMEM;
  1208	
  1209		rrpc->gcb_pool = mempool_create_slab_pool(rrpc->dev->geo.nr_luns,
  1210									rrpc_gcb_cache);
  1211		if (!rrpc->gcb_pool)
  1212			return -ENOMEM;
  1213	
  1214		rrpc->rq_pool = mempool_create_slab_pool(64, rrpc_rq_cache);
  1215		if (!rrpc->rq_pool)
  1216			return -ENOMEM;
  1217	
  1218		spin_lock_init(&rrpc->inflights.lock);
  1219		INIT_LIST_HEAD(&rrpc->inflights.reqs);
  1220	
  1221		return 0;
  1222	}
  1223	
  1224	static void rrpc_core_free(struct rrpc *rrpc)
  1225	{
  1226		mempool_destroy(rrpc->page_pool);
  1227		mempool_destroy(rrpc->gcb_pool);
  1228		mempool_destroy(rrpc->rq_pool);
  1229	}
  1230	
  1231	static void rrpc_luns_free(struct rrpc *rrpc)
  1232	{
  1233		struct nvm_lun *lun;
  1234		struct rrpc_lun *rlun;
  1235		int i;
  1236	
  1237		if (!rrpc->luns)
  1238			return;
  1239	
  1240		for (i = 0; i < rrpc->nr_luns; i++) {
  1241			rlun = &rrpc->luns[i];
  1242			lun = rlun->parent;
  1243			if (!lun)
  1244				break;
  1245			vfree(rlun->blocks);
  1246		}
  1247	
  1248		kfree(rrpc->luns);
  1249	}
  1250	
  1251	static int rrpc_bb_discovery(struct nvm_tgt_dev *dev, struct rrpc_lun *rlun)
  1252	{
  1253		struct nvm_geo *geo = &dev->geo;
  1254		struct rrpc_block *rblk;
  1255		struct ppa_addr ppa;
  1256		u8 *blks;
  1257		int nr_blks;
  1258		int i;
  1259		int ret;
  1260	
  1261		nr_blks = geo->blks_per_lun * geo->plane_mode;
  1262		blks = kmalloc(nr_blks, GFP_KERNEL);
  1263		if (!blks)
  1264			return -ENOMEM;
  1265	
  1266		ppa.ppa = 0;
  1267		ppa.g.ch = rlun->parent->chnl_id;
  1268		ppa.g.lun = rlun->parent->lun_id;
  1269	
  1270		ret = nvm_get_bb_tbl(dev->parent, ppa, blks);
  1271		if (ret) {
  1272			pr_err("rrpc: could not get BB table\n");
> 1273			kfree(blks);
  1274			goto out;
  1275		}
  1276	
  1277		nr_blks = nvm_bb_tbl_fold(dev->parent, blks, nr_blks);
  1278		if (nr_blks < 0)
  1279			return nr_blks;
  1280	
  1281		rlun->nr_free_blocks = geo->blks_per_lun;
  1282		for (i = 0; i < nr_blks; i++) {
  1283			if (blks[i] == NVM_BLK_T_FREE)
  1284				continue;
  1285	
  1286			rblk = &rlun->blocks[i];
  1287			list_move_tail(&rblk->list, &rlun->bb_list);
  1288			rblk->state = NVM_BLK_ST_BAD;
  1289			rlun->nr_free_blocks--;
  1290		}
  1291	
  1292	out:
> 1293		kfree(blks);
  1294		return ret;
  1295	}
  1296	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
