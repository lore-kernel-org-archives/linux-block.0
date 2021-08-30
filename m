Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4677EC432BE
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 14:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5D76023E
	for <linux-block@archiver.kernel.org>; Mon, 30 Aug 2021 14:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhH3Okq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhH3Okq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 10:40:46 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60FC061575
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 07:39:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e186so20171123iof.12
        for <linux-block@vger.kernel.org>; Mon, 30 Aug 2021 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t7gRIB3ULkbi+YOlk8DmUxku33Kes9bRf5fMyDiIJjE=;
        b=bMFLxzrOqS8QhUcz+7WZrvSNo8Ru/oF1gC08s3+ZrjpsXkE4oCxXHW5Brh6pJ4xmYy
         n7PWC7NVRDfEvqYoFTAYSbBWvABgNk44G1THwhhhlJC+dozIxkc6a7cdWajHmdJI0K4e
         dIefc3Zq3pp5Y6bfgafOr2HCmGoQmIO0JYgRFzqUXn63JM/+dhPRgLyRiQe+ssp2xKpP
         GpcUmNje3RO7nja5xtwAkauRFjw866a4iXXhG1bB90axU3Qk7YPqFTHrPH5JnjriemFp
         Fwo+Fgi7rYnkRY06sQlKAoBX+oaKGsSt+oKPyd+x8LbyM3uCSghaF9zeQG2dRhopHQxf
         iiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t7gRIB3ULkbi+YOlk8DmUxku33Kes9bRf5fMyDiIJjE=;
        b=MZyWUEZfwuSf+Ln0Uxu8UzU0/ov2AUnXtXdrqIFzZgd5/xlFS5rYRb/xfiBE/i0EFq
         dknVEYOkZl/Jtz4BafMV4e+kaOQ63r6oUxE1dBvt4ry7H5O4N3q3uZs0zdMU7UnotUce
         /6dMk1EE8JbgYa+vrhBKMJt/47JFPhdonPGNaWrnFoN63brvmkrW4v1CnuAphFEdHJsz
         kVFNmE92ZwNkx93+w4E0/6ASvRsSerOQc0CyNzNI7AZnBNQAL0NkAj56wyL9sx1DpX2i
         gyaWmyjVMTtQ5VLhUph5ymz9kRjALWlxv6AVMYQvK0HoLDZNzWSFyq+TqNxHWIWSQ646
         p1qQ==
X-Gm-Message-State: AOAM532EQIdiwRYm403uwIBV1DzjRCMrta42w3rZOA9q43xzGMi+pvEs
        9loUjfZeHeh6587OVsSUF7fXoqq/MmFiyw==
X-Google-Smtp-Source: ABdhPJylEfI0A4WuE5fnnR4LK8ZB/i9B0p0LVq3RKnO/0sIrqf201L612lOt98ra/t+ja4HxGGdnZA==
X-Received: by 2002:a6b:7a03:: with SMTP id h3mr18639834iom.39.1630334391837;
        Mon, 30 Aug 2021 07:39:51 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id f5sm8740078ils.3.2021.08.30.07.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 07:39:51 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.15-rc1
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <8e3f076e-4af2-8aa4-64a2-de65e231bfd7@kernel.dk>
Date:   Mon, 30 Aug 2021 08:39:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Sitting on top of the core block changes, here are the driver changes
for the 5.15 merge window:

- NVMe updates via Christoph:
	- suspend improvements for devices with an HMB (Keith Busch)
	- handle double completions more gacefull (Sagi Grimberg)
	- cleanup the selects for the nvme core code a bit
	  (Sagi Grimberg)
	- don't update queue count when failing to set io queues
	  (Ruozhu Li)
	- various nvmet connect fixes (Amit Engel)
	- cleanup lightnvm leftovers (Keith Busch, me)
	- small cleanups (Colin Ian King, Hou Pu)
	- add tracing for the Set Features command (Hou Pu)
	- CMB sysfs cleanups (Keith Busch)
	- add a mutex_destroy call (Keith Busch)

- Remove lightnvm subsystem. It's served its purpose and ultimately led
  to zoned nvme support, we no longer need it (Christoph)

- Revert floppy O_NDELAY fix (Denis)

- nbd fixes (Hou, Pavel, Baokun)

- nbd locking fixes (Tetsuo)

- nbd device removal fixes (Christoph)

- raid10 rcu warning fix (Xiao)

- raid1 write behind fix (Guoqing)

- rnbd fixes (Gioh, Md Haris)

- Misc fixes (Colin)

Note that this will throw a single merge conflict, due to lightnvm being
removed. The resolution is simple:

diff --cc drivers/nvme/host/core.c
index 68acd33c3856,b9a46c54f714..8679a108f571
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@@ -3758,17 -3757,11 +3753,10 @@@ static void nvme_alloc_ns(struct nvme_c
  	if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
  		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
  			ns->head->instance);
 -	ns->disk = disk;
  
  	if (nvme_update_ns_info(ns, id))
 -		goto out_put_disk;
 +		goto out_unlink_ns;
  
- 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
- 		if (nvme_nvm_register(ns, disk->disk_name, node)) {
- 			dev_warn(ctrl->device, "LightNVM init failure\n");
- 			goto out_unlink_ns;
- 		}
- 	}
- 
  	down_write(&ctrl->namespaces_rwsem);
  	list_add_tail(&ns->list, &ctrl->namespaces);
  	up_write(&ctrl->namespaces_rwsem);

Apart from that, merges cleanly. Please pull!


The following changes since commit 2bc1f6e442eec88fa60f1ee6bef2c9871227cf8a:

  block: remove blk-mq-sysfs dead code (2021-08-02 13:37:29 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.15/drivers-2021-08-30

for you to fetch changes up to b5b0eba590f08e2b06c830b8343c1da7059c7a88:

  Merge tag 'floppy-for-5.15' of https://github.com/evdenis/linux-floppy into for-5.15/drivers (2021-08-29 06:50:58 -0600)

----------------------------------------------------------------
for-5.15/drivers-2021-08-30

----------------------------------------------------------------
Amit Engel (3):
      nvmet: pass back cntlid on successful completion
      nvmet: avoid duplicate qid in connect cmd
      nvmet: check that host sqsize does not exceed ctrl MQES

Baokun Li (1):
      nbd: add the check to prevent overflow in __nbd_ioctl()

Christoph Hellwig (10):
      nbd: refactor device removal
      nbd: remove nbd_del_disk
      nbd: return the allocated nbd_device from nbd_dev_add
      nbd: refactor device search and allocation in nbd_genl_connect
      nbd: reduce the nbd_index_mutex scope
      remove the lightnvm subsystem
      nvme: remove the unused NVME_NS_* enum
      nbd: reset NBD to NULL when restarting in nbd_genl_connect
      nbd: only return usable devices from nbd_find_unused
      nbd: remove nbd->destroy_complete

Colin Ian King (2):
      xen-blkfront: Remove redundant assignment to variable err
      nvmet: remove redundant assignments of variable status

Denis Efremov (1):
      Revert "floppy: reintroduce O_NDELAY fix"

Gioh Kim (1):
      block/rnbd-clt: Use put_cpu_ptr after get_cpu_ptr

Guoqing Jiang (1):
      raid1: ensure write behind bio has less than BIO_MAX_VECS sectors

Hou Pu (3):
      nvme-fabrics: remove superfluous nvmf_host_put in nvmf_parse_options
      nvme: add set feature tracing support
      nvmet: add set feature tracing support

Hou Tao (1):
      nbd: do del_gendisk() asynchronously for NBD_DESTROY_ON_DISCONNECT

Jens Axboe (3):
      Merge tag 'nvme-5.15-2021-08-18' of git://git.infradead.org/nvme into for-5.15/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.15/drivers
      Merge tag 'floppy-for-5.15' of https://github.com/evdenis/linux-floppy into for-5.15/drivers

Keith Busch (6):
      nvme-pci: use attribute group for cmb sysfs
      nvme-pci: cmb sysfs: one file, one value
      nvme-pci: disable hmb on idle suspend
      nvme: allow user toggling hmb usage
      nvme-tcp: pair send_mutex init with destroy
      nvme: remove nvm_ndev from ns

Md Haris Iqbal (1):
      block/rnbd: Use sysfs_emit instead of s*printf function for sysfs show

Pavel Skripkin (1):
      block: nbd: add sanity check for first_minor

Ruozhu Li (2):
      nvme-tcp: don't update queue count when failing to set io queues
      nvme-rdma: don't update queue count when failing to set io queues

Sagi Grimberg (5):
      params: lift param_set_uint_minmax to common code
      nvme-pci: limit maximum queue depth to 4095
      nvme-tcp: don't check blk_mq_tag_to_rq when receiving pdu data
      nvme: code command_id with a genctr for use-after-free validation
      nvme: Have NVME_FABRICS select NVME_CORE instead of transport drivers

Tetsuo Handa (3):
      nbd: add missing locking to the nbd_dev_add error path
      nbd: prevent IDR lookups from finding partially initialized devices
      nbd: set nbd->index before releasing nbd_index_mutex

Xiao Ni (1):
      md/raid10: Remove unnecessary rcu_dereference in raid10_handle_discard

 Documentation/driver-api/index.rst                 |    1 -
 Documentation/driver-api/lightnvm-pblk.rst         |   21 -
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 MAINTAINERS                                        |    9 -
 drivers/Kconfig                                    |    2 -
 drivers/Makefile                                   |    1 -
 drivers/block/floppy.c                             |   30 +-
 drivers/block/nbd.c                                |  178 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c                |   33 +-
 drivers/block/rnbd/rnbd-clt.c                      |    2 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c                |   14 +-
 drivers/block/xen-blkfront.c                       |    1 -
 drivers/lightnvm/Kconfig                           |   44 -
 drivers/lightnvm/Makefile                          |   11 -
 drivers/lightnvm/core.c                            | 1440 -------------
 drivers/lightnvm/pblk-cache.c                      |  137 --
 drivers/lightnvm/pblk-core.c                       | 2151 --------------------
 drivers/lightnvm/pblk-gc.c                         |  726 -------
 drivers/lightnvm/pblk-init.c                       | 1324 ------------
 drivers/lightnvm/pblk-map.c                        |  210 --
 drivers/lightnvm/pblk-rb.c                         |  858 --------
 drivers/lightnvm/pblk-read.c                       |  474 -----
 drivers/lightnvm/pblk-recovery.c                   |  874 --------
 drivers/lightnvm/pblk-rl.c                         |  254 ---
 drivers/lightnvm/pblk-sysfs.c                      |  728 -------
 drivers/lightnvm/pblk-trace.h                      |  145 --
 drivers/lightnvm/pblk-write.c                      |  665 ------
 drivers/lightnvm/pblk.h                            | 1358 ------------
 drivers/md/raid1.c                                 |   19 +
 drivers/md/raid10.c                                |   14 +-
 drivers/nvme/host/Kconfig                          |    4 +-
 drivers/nvme/host/Makefile                         |    1 -
 drivers/nvme/host/core.c                           |   16 +-
 drivers/nvme/host/fabrics.c                        |    1 -
 drivers/nvme/host/ioctl.c                          |    4 +-
 drivers/nvme/host/lightnvm.c                       | 1274 ------------
 drivers/nvme/host/nvme.h                           |   79 +-
 drivers/nvme/host/pci.c                            |  187 +-
 drivers/nvme/host/rdma.c                           |    8 +-
 drivers/nvme/host/tcp.c                            |   44 +-
 drivers/nvme/host/trace.c                          |   18 +-
 drivers/nvme/target/Kconfig                        |    2 -
 drivers/nvme/target/core.c                         |    1 +
 drivers/nvme/target/fabrics-cmd.c                  |   38 +-
 drivers/nvme/target/loop.c                         |    4 +-
 drivers/nvme/target/trace.c                        |   18 +-
 drivers/nvme/target/zns.c                          |    5 +-
 include/linux/lightnvm.h                           |  697 -------
 include/linux/moduleparam.h                        |    2 +
 include/uapi/linux/lightnvm.h                      |  224 --
 kernel/params.c                                    |   18 +
 net/sunrpc/xprtsock.c                              |   18 -
 52 files changed, 462 insertions(+), 13926 deletions(-)
 delete mode 100644 Documentation/driver-api/lightnvm-pblk.rst
 delete mode 100644 drivers/lightnvm/Kconfig
 delete mode 100644 drivers/lightnvm/Makefile
 delete mode 100644 drivers/lightnvm/core.c
 delete mode 100644 drivers/lightnvm/pblk-cache.c
 delete mode 100644 drivers/lightnvm/pblk-core.c
 delete mode 100644 drivers/lightnvm/pblk-gc.c
 delete mode 100644 drivers/lightnvm/pblk-init.c
 delete mode 100644 drivers/lightnvm/pblk-map.c
 delete mode 100644 drivers/lightnvm/pblk-rb.c
 delete mode 100644 drivers/lightnvm/pblk-read.c
 delete mode 100644 drivers/lightnvm/pblk-recovery.c
 delete mode 100644 drivers/lightnvm/pblk-rl.c
 delete mode 100644 drivers/lightnvm/pblk-sysfs.c
 delete mode 100644 drivers/lightnvm/pblk-trace.h
 delete mode 100644 drivers/lightnvm/pblk-write.c
 delete mode 100644 drivers/lightnvm/pblk.h
 delete mode 100644 drivers/nvme/host/lightnvm.c
 delete mode 100644 include/linux/lightnvm.h
 delete mode 100644 include/uapi/linux/lightnvm.h

-- 
Jens Axboe

