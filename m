Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26662 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbcLHKz4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2016 05:55:56 -0500
Date: Thu, 8 Dec 2016 13:47:32 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: m@bjorling.me
Cc: linux-block@vger.kernel.org
Subject: [bug report] lightnvm: core on-disk initialization
Message-ID: <20161208104731.GA11393@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Matias Bj�rling,

The patch e3eb3799f7e0: "lightnvm: core on-disk initialization" from
Jan 12, 2016, leads to the following static checker warning:

	drivers/lightnvm/sysblk.c:409 nvm_get_sysblock()
	warn: missing error code here? 'kzalloc()' failed.

drivers/lightnvm/sysblk.c
   398          mutex_lock(&dev->mlock);
   399          ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 0);
   400          if (ret)
   401                  goto err_sysblk;
   402  
   403          /* no sysblocks initialized */
   404          if (!s.nr_ppas)
   405                  goto err_sysblk;

Do we want to return 0 or an error code here?  I'm not sure.

   406  
   407          cur = kzalloc(sizeof(struct nvm_system_block), GFP_KERNEL);
   408          if (!cur)
   409                  goto err_sysblk;

We should set "ret = -ENOMEM;" before the goto.

   410  
   411          /* find the latest block across all sysblocks */
   412          for (i = 0; i < s.nr_rows; i++) {
   413                  for (j = 0; j < MAX_BLKS_PR_SYSBLK; j++) {
   414                          struct ppa_addr ppa = s.ppas[scan_ppa_idx(i, j)];
   415  
   416                          ret = nvm_scan_block(dev, &ppa, cur);
   417                          if (ret > 0)
   418                                  found = 1;
   419                          else if (ret < 0)
   420                                  break;
   421                  }
   422          }
   423  
   424          nvm_sysblk_to_cpu(info, cur);
   425  
   426          kfree(cur);
   427  err_sysblk:
   428          mutex_unlock(&dev->mlock);
   429  
   430          if (found)
   431                  return 1;
   432          return ret;
   433  }
   434  
   435  int nvm_update_sysblock(struct nvm_dev *dev, struct nvm_sb_info *new)
   436  {
   437          /* 1. for each latest superblock
   438           * 2. if room
   439           *    a. write new flash page entry with the updated information
   440           * 3. if no room
   441           *    a. find next available block on lun (linear search)
   442           *       if none, continue to next lun
   443           *       if none at all, report error. also report that it wasn't
   444           *       possible to write to all superblocks.
   445           *    c. write data to block.
   446           */
   447          struct ppa_addr sysblk_ppas[MAX_SYSBLKS];
   448          struct sysblk_scan s;
   449          struct nvm_system_block *cur;
   450          int i, j, ppaidx, found = 0;
   451          int ret = -ENOMEM;
   452  
   453          if (!dev->ops->get_bb_tbl)
   454                  return -EINVAL;
   455  
   456          nvm_setup_sysblk_scan(dev, &s, sysblk_ppas);
   457  
   458          mutex_lock(&dev->mlock);
   459          ret = nvm_get_all_sysblks(dev, &s, sysblk_ppas, 0);
   460          if (ret)
   461                  goto err_sysblk;
   462  
   463          cur = kzalloc(sizeof(struct nvm_system_block), GFP_KERNEL);
   464          if (!cur)
   465                  goto err_sysblk;

Same here as well.

   466  

regards,
dan carpenter
