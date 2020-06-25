Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CD8C433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2137F20768
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 19:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="mTdw4JzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406796AbgFYTv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406679AbgFYTv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 15:51:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052E3C08C5C1
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:51:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so7157972ejb.4
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DcDHPN9kms1mvGJ+G7SU9GbYWwpk8frXL5FXV5+IcyU=;
        b=mTdw4JzCb/bbzkVPxDnjZTbqdAdeRLdRytGgOOBo8fAfJrX43OGUDufvuosFJ1n2/C
         eqoswxjmwfbt2dL6HV9/NLYahczrRRYjI7w3yQpRx3qdy4fhH6LLvnrxa7ZWfejKXVw3
         7h9SqMpfWp7I6e+WpOyPfC7mVDbquJwIa+MRY0W/Wnaqyv5wcrtCO4gQ4+MoAIGMEIr9
         pMpY885m8Rq6T5LhJmc4o2qlnXrsa04MCfPzHZC7fkxQm25as2P8vD1kzxpERRAkxySZ
         Mo25ZPeBJrxfB3Y/CeWbeJFmG/zIZgvl1dIJnaIiIiAJmaGuQ0YEcIF7Cg5itE2KmGOa
         ZC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DcDHPN9kms1mvGJ+G7SU9GbYWwpk8frXL5FXV5+IcyU=;
        b=Zd6wBQpGj4H7aH6qcswKYp1neTTJhpY8QoTtLwKuE+td1q1WN+ekzcyereu3KY/xqB
         NKeDzhwN3Y7N4o45d4Q2hKB3osdk9zLR1HDmUCVH4Aoy17hC9N7GhShLxJkMgu6LjoP6
         eB29thSPE30z1oO21ZyWDpZ2THhY0Lj3U6WBY2NezZRX5nElf7b7yGDtgbuCcRN4lT7a
         bbnUDZV60e2uPmwKxbaXxQzqxLYyknRzw/QRWpRupib1Ksi7IK51YHi23E4lBc4izIni
         8nx0KHIjg7ywpFOBM3bafZ7albtYa55Rq34QE8WMyc49NR8HoRG0AZR8bLscqV/vSkrd
         XWMA==
X-Gm-Message-State: AOAM531PbzYFYjfyGEUM4gY1rQQxdq+HPz52Pag3dpt8WV9Yb3hW456i
        kLGEByTYi/G8XEccuJ96VnIw5Q==
X-Google-Smtp-Source: ABdhPJyK5M5/nzFAIAV0QK/pk/bTAv0CWknEH3zNrXlspR0Jbpalq6wkkb8sM7jlE9UNadBpZahB4Q==
X-Received: by 2002:a17:906:3653:: with SMTP id r19mr29431666ejb.246.1593114686614;
        Thu, 25 Jun 2020 12:51:26 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id y62sm19411472edy.61.2020.06.25.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:51:25 -0700 (PDT)
Date:   Thu, 25 Jun 2020 21:51:25 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Message-ID: <20200625195125.ccertaiuilofpn6c@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <9ac40166-5731-692a-d476-0da9aad2a9aa@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ac40166-5731-692a-d476-0da9aad2a9aa@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.06.2020 17:13, Matias Bjørling wrote:
>On 25/06/2020 14.21, Javier González wrote:
>>From: Javier González <javier.gonz@samsung.com>
>>
>>Add zone attributes field to the blk_zone structure. Use ZNS attributes
>>as base for zoned block devices in general.
>>
>>Signed-off-by: Javier González <javier.gonz@samsung.com>
>>Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>---
>>  drivers/nvme/host/zns.c       |  1 +
>>  include/uapi/linux/blkzoned.h | 13 ++++++++++++-
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>>index 258d03610cc0..7d8381fe7665 100644
>>--- a/drivers/nvme/host/zns.c
>>+++ b/drivers/nvme/host/zns.c
>>@@ -195,6 +195,7 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>>  	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>>+	zone.attr = entry->za;
>>  	return cb(&zone, idx, data);
>>  }
>>diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
>>index 0c49a4b2ce5d..2e43a00e3425 100644
>>--- a/include/uapi/linux/blkzoned.h
>>+++ b/include/uapi/linux/blkzoned.h
>>@@ -82,6 +82,16 @@ enum blk_zone_report_flags {
>>  	BLK_ZONE_REP_CAPACITY	= (1 << 0),
>>  };
>>+/**
>>+ * Zone Attributes
>>+ */
>>+enum blk_zone_attr {
>>+	BLK_ZONE_ATTR_ZFC	= 1 << 0,
>>+	BLK_ZONE_ATTR_FZR	= 1 << 1,
>>+	BLK_ZONE_ATTR_RZR	= 1 << 2,
>
>The RZR bit is equivalent to the RESET bit accessible through the 
>reset byte in struct blk_zone.
>
>ZFC is tied to Zone Active Excursions, as there is no support in the 
>kernel zone model for that. This should probably not be added until 
>there is generic support.
>
>Damien, could we overload the struct blk_zine reset variable for FZR? 
>I don't believe we can due to backward compatibility. Is that your 
>understanding as well?
>
>>+	BLK_ZONE_ATTR_ZDEV	= 1 << 7,
>
>There is not currently an equivalent for zone descriptor extensions in 
>ZAC/ZBC. The addition of this field should probably be in a patch that 
>adds generic support for zone descriptor extensions.

The intention was to just report the values on the IOCTL and make sure
that changes to struct blk_zone are OK.

>>+};
>>+
>>  /**
>>   * struct blk_zone - Zone descriptor for BLKREPORTZONE ioctl.
>>   *
>>@@ -108,7 +118,8 @@ struct blk_zone {
>>  	__u8	cond;		/* Zone condition */
>>  	__u8	non_seq;	/* Non-sequential write resources active */
>>  	__u8	reset;		/* Reset write pointer recommended */
>>-	__u8	resv[4];
>>+	__u8	attr;		/* Zone attributes */
>>+	__u8	resv[3];
>>  	__u64	capacity;	/* Zone capacity in number of sectors */
>>  	__u8	reserved[24];
>>  };
>
>
