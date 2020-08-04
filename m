Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB39C433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827F12070A
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 16:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kU15dpfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgHDQWg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgHDQWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 12:22:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6A9C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 09:22:23 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l17so24489558ilq.13
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mVBzrf5qNdJdvLu9ltowtMsWDSIWuUdl+s8fqYRcyDQ=;
        b=kU15dpfLcRfVjYzosfuz45FEwnqbxx80x659bpyZMKfbet0ByHB5JQb+VO4/z6coNH
         AwvYBb16+8SCP+GYJeLbPTf5EdcE47/9L/aqTtI+qAwVK17pcgiXOXlXNWI6PBXziibq
         DIXq/oQpunINQ4rr/wD/qtPXh5iVru2GLfk/xvZO2FqCarZC3TIIZET0fcfthEgDBROQ
         g/nMU7sOvmywndzX3Q7Bqr2EQoEi67nXa/9hhnQy9EWmQ895XJTrgvxK99T6KxWUqpEh
         lrek3Y3/WcOUVbrLuTDVCSGyTUV4r+5YwS/EcYw+3dzY9TaHwYI5DZstfdD66rP0IJVe
         AA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mVBzrf5qNdJdvLu9ltowtMsWDSIWuUdl+s8fqYRcyDQ=;
        b=iJiiHlX/9jAPuboA3cNcZoYLwOkuAoKs+NOLP9wiLde6bi4EACDKCEX/bvYPq6jZYD
         luj0m8z7iqaoxFwrfosrm0SwTHANpbVToAAvDotnLtYzW5jE3gGfgxUv/86KAGVSxp1q
         Kx2J5ivOvujNDcf5yV0CJSshu8UablKjIkmsFquLbOJBPjQriJEHOtcQnRAY2mIE20sZ
         y0AaAK6Hrhy6R7j9nkOU1vv+XAkZscXyL5kT/+Bm6qDkuOy1XRsZkQSpKbK0s0XXR4oN
         zk2nk9OaU8+eDB6uDcHZz9BvTEXOokFOTcqfsEyuXb55b8n16z9JUz4KyX8HGiHiBLb9
         qang==
X-Gm-Message-State: AOAM5333iiFj+GJW7a9pFUGOHqiIuRFA9ycAwSQ/6JjMvwDkMjWw/Zqx
        KXtVbZZxz1qUckPeQl1okmEBPhC5LOU=
X-Google-Smtp-Source: ABdhPJyqW3SxXgI9EfnaciDVHby6pNucv8nGMlSfU+tKiHDirQEIApdPfn1LSTz/AqXWv+G/rGOkGA==
X-Received: by 2002:a92:c644:: with SMTP id 4mr5451634ill.3.1596558142464;
        Tue, 04 Aug 2020 09:22:22 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h1sm12394518iob.8.2020.08.04.09.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:22:22 -0700 (PDT)
Subject: Re: [GIT PULL] Block driver changes for 5.9-rc1
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ea8f5f71-477c-1668-cef6-a30c8d1aa3e6@kernel.dk>
Message-ID: <ee95f92b-d42b-6dda-fd73-1f630374b6e2@kernel.dk>
Date:   Tue, 4 Aug 2020 10:22:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ea8f5f71-477c-1668-cef6-a30c8d1aa3e6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/20 9:39 AM, Jens Axboe wrote:
> Hi Linus,
> 
> Changes in this pull request:
> 
> - NVMe
> 	- ZNS support (Aravind, Keith, Matias, Niklas)
> 	- Misc cleanups, optimizations, fixes (Baolin, Chaitanya, David,
> 		Dongli, Max, Sagi)
> 
> - null_blk zone capacity support (Aravind)
> 
> - MD
> 	- raid5/6 fixes (ChangSyun)
> 	- Warning fixes (Damien)
> 	- raid5 stripe fixes (Guoqing, Song, Yufen)
> 	- sysfs deadlock fix (Junxiao)
> 	- raid10 deadlock fix (Vitaly)
> 
> - struct_size conversions (Gustavo)
> 
> - Set of bcache updates/fixes (Coly)
> 
> 
> Please pull!

Forgot to mention that this will trigger a merge conflict with master,
due to this commit that went in late for 5.8:

commit 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jul 28 13:09:03 2020 +0200

    nvme: add a Identify Namespace Identification Descriptor list quirk

and the resolution is simple, just delete the identified section. Below
is my merge:

diff --cc drivers/nvme/host/core.c
index 6bdcdd984394,05aa568a60af..767d62985bba
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@@ -1097,14 -1270,10 +1270,13 @@@ static int nvme_identify_ns_descs(struc
  		struct nvme_ns_ids *ids)
  {
  	struct nvme_command c = { };
- 	int status;
+ 	bool csi_seen = false;
+ 	int status, pos, len;
  	void *data;
- 	int pos;
- 	int len;
  
 +	if (ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)
 +		return 0;
 +
  	c.identify.opcode = nvme_admin_identify;
  	c.identify.nsid = cpu_to_le32(nsid);
  	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
diff --cc drivers/nvme/host/nvme.h
index 9c5b82af7978,c5c1bac797aa..ebb8c3ed3885
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@@ -699,11 -727,38 +744,41 @@@ static inline void nvme_mpath_wait_free
  static inline void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
  {
  }
 +static inline void nvme_mpath_update_disk_size(struct gendisk *disk)
 +{
 +}
  #endif /* CONFIG_NVME_MULTIPATH */
  
+ #ifdef CONFIG_BLK_DEV_ZONED
+ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
+ 			  unsigned lbaf);
+ 
+ int nvme_report_zones(struct gendisk *disk, sector_t sector,
+ 		      unsigned int nr_zones, report_zones_cb cb, void *data);
+ 
+ blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
+ 				       struct nvme_command *cmnd,
+ 				       enum nvme_zone_mgmt_action action);
+ #else
+ #define nvme_report_zones NULL
+ 
+ static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
+ 		struct request *req, struct nvme_command *cmnd,
+ 		enum nvme_zone_mgmt_action action)
+ {
+ 	return BLK_STS_NOTSUPP;
+ }
+ 
+ static inline int nvme_update_zone_info(struct gendisk *disk,
+ 					struct nvme_ns *ns,
+ 					unsigned lbaf)
+ {
+ 	dev_warn(ns->ctrl->device,
+ 		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");
+ 	return -EPROTONOSUPPORT;
+ }
+ #endif
+ 
  #ifdef CONFIG_NVM
  int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
  void nvme_nvm_unregister(struct nvme_ns *ns);

-- 
Jens Axboe

