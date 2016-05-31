Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41040 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbcEaLHY (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 31 May 2016 07:07:24 -0400
Date: Tue, 31 May 2016 14:07:11 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: m@bjorling.me
Cc: linux-block@vger.kernel.org
Subject: re: lightnvm: core on-disk initialization
Message-ID: <20160531110711.GA16633@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Matias Bj�rling,

The patch e3eb3799f7e0: "lightnvm: core on-disk initialization" from
Jan 12, 2016, leads to the following static checker warning:

	drivers/lightnvm/sysblk.c:422 nvm_get_sysblock()
	warn: missing error code here? 'kzalloc()' failed.

drivers/lightnvm/sysblk.c
   390  int nvm_get_sysblock(struct nvm_dev *dev, struct nvm_sb_info *info)
   391  {
   392          struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
   393          struct sysblk_scan s;
   394          struct nvm_system_block *cur;
   395          int i, j, found = 0;
   396          int ret = -ENOMEM;
                    ^^^^^^^^^^^^^
Not useful.

   397  
   398          /*
   399           * 1. setup sysblk locations
   400           * 2. get bad block list
   401           * 3. filter on host-specific (type 3)
   402           * 4. iterate through all and find the highest seq nr.
   403           * 5. return superblock information
   404           */
   405  
   406          if (!dev->ops->get_bb_tbl)
   407                  return -EINVAL;
   408  
   409          nvm_setup_sysblk_scan(dev, &s, sysblk_ppas);
   410  
   411          mutex_lock(&dev->mlock);
   412          ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 0);
   413          if (ret)
   414                  goto err_sysblk;
   415  
   416          /* no sysblocks initialized */
   417          if (!s.nr_ppas)
   418                  goto err_sysblk;

Should this be an error?  Presumably no.

   419  
   420          cur = kzalloc(sizeof(struct nvm_system_block), GFP_KERNEL);
   421          if (!cur)
   422                  goto err_sysblk;

This definitely should be.

   423  
   424          /* find the latest block across all sysblocks */
   425          for (i = 0; i < s.nr_rows; i++) {
   426                  for (j = 0; j < MAX_BLKS_PR_SYSBLK; j++) {
   427                          struct ppa_addr ppa = s.ppas[scan_ppa_idx(i, j)];
   428  
   429                          ret = nvm_scan_block(dev, &ppa, cur);
   430                          if (ret > 0)
   431                                  found = 1;
   432                          else if (ret < 0)
   433                                  break;
   434                  }
   435          }
   436  
   437          nvm_sysblk_to_cpu(info, cur);
   438  
   439          kfree(cur);
   440  err_sysblk:

This label name is confusing.  Better to call it something like
err_unlock.

   441          mutex_unlock(&dev->mlock);
   442  
   443          if (found)
   444                  return 1;
   445          return ret;
   446  }

regards,
dan carpenter
