Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7AAC4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F296E21734
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560282604;
	bh=slMI4YBdZJaHybfeEXJuUQb+nzTBTdVFAV5PArUaS/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZEswfn40Fk+k4vJathmuuXUA+e6ft51O3q0NIekyBuOfy8IxjxgkJBGx+EUXOTUM
	 zclgUSPTvhjZdSnuCzkCw9JZ2cLLC4NrREYxDA1Jo3DfdTPBHGstp5fAsNOtftQIna
	 8issqP1sR8SOX2ud8Q4C//U49IwqIdlAQYiUxH1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405521AbfFKTuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:50:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47046 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405039AbfFKTuD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 15:50:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so8069056pfy.13
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2019 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lY+HFPXQjnhdVN6fSFWWZeZa7jthQVIc7XJczuJqp8Y=;
        b=d0uAZ2FBp3dWsYFMB4CpKCGSWfZS4QfDM+fw1chX0UYmhfT/YkBpN9AEJJDXsirrns
         NeTe4Ek7l7PvcWV3h6FWkgxEHmsNf0NaRSM6F3+gpA5JAlB6ZJNdtP0lXbj+pfvndlc1
         M9nN9IHVToz1s66XS9tBVRPehTbj7CClzyfh3yF/OqEbh+BAweJbO65J1dTi8XfguTta
         0wSI4DE+epp0SYuoEiyTJiq1ewnTZUZkZRlRrOstPPN1F1NfR/y8RJuTw0xdaNTInTrl
         4UbB+CV9xB7aI+2rx//BXS9+1z8lGtB/a0TxwFAk1pt3v8PVYl/9H4h0PRmyDoFefrA/
         40kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lY+HFPXQjnhdVN6fSFWWZeZa7jthQVIc7XJczuJqp8Y=;
        b=KKHQK4WgQSMc8SJbaPJ/+rwqU4ej3h1DUKSGZui0C16FzmNFpaUsXCVuRsEcnhI9o2
         iQTVIK0p8AuJd2RQ88KTKe5ywsEufuMAzMw/ZlNSGgO23oMAc/UUE3z1giy/W/U5aF9A
         h9X/w9PjO4AQLWj3Fw1TIESa1BGKIfzh0tqO60VfO5nPtWOrMuGsnRCQHYF1Y/suJf1x
         nSOFM6BNKTJaWSug57fRwUulPV3MpAIw7juXiaR3a/Q7JLUKWkwWB5tT499nlW0bIefu
         whV3xK1kyiqLS7s3ChyDMrtJPOlXepCCS44RnsfDlG4FdD6ZH75DtGaIEY2yZ6OeW+Be
         bAOw==
X-Gm-Message-State: APjAAAVTBnteuZaeX0IOR2Bw26KI7+CgraKzCcxQc4zMAMQJXVKUQdcv
        oPOo33wBNtdtjACj+YLuS5Q=
X-Google-Smtp-Source: APXvYqyhFHkzCgOBVQojMqBQXQUpeBp3bNdkiIskuK8l1rHzNJlzhUUvMUor4aGRDqoyVP97UlLl4A==
X-Received: by 2002:a17:90a:bc08:: with SMTP id w8mr29131755pjr.45.1560282602407;
        Tue, 11 Jun 2019 12:50:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id y133sm16053422pfb.28.2019.06.11.12.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 12:50:01 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:49:59 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fam Zheng <fam@euphon.net>
Subject: [PATCH block/for-5.2-fixes] bfq: use io.weight interface file
 instead of io.bfq.weight
Message-ID: <20190611194959.GJ3341036@devbig004.ftw2.facebook.com>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
 <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
 <90A8C242-E45A-4D6E-8797-598893F86393@linaro.org>
 <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610154820.GA3341036@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Description mostly stolen from 19e9da9e86c4 ("block, bfq: add weight
symlink to the bfq.weight cgroup parameter")

Many userspace tools and services use the proportional-share policy of
the blkio/io cgroups controller. The CFQ I/O scheduler implemented
this policy for the legacy block layer. To modify the weight of a
group in case CFQ was in charge, the 'weight' parameter of the group
must be modified. On the other hand, the BFQ I/O scheduler implements
the same policy in blk-mq, but, with BFQ, the parameter to modify has
a different name: bfq.weight (forced choice until legacy block was
present, because two different policies cannot share a common
parameter in cgroups).

Due to CFQ legacy, most if not all userspace configurations still use
the parameter 'weight', and for the moment do not seem likely to be
changed. But, when CFQ went away with legacy block, such a parameter
ceased to exist.

19e9da9e86c4 ("block, bfq: add weight symlink to the bfq.weight cgroup
parameter") tried to solve the problem by creating a symlink but there
doesn't seem to be a good reason for the added complexity.  Make bfq
simply create interface file io.weight instead of io.bfq.weight.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Angelo Ruocco <angeloruocco90@gmail.com>
---
 block/bfq-cgroup.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index b3796a40a61a..c68c6aa22154 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1045,8 +1045,8 @@ struct blkcg_policy blkcg_policy_bfq = {
 
 struct cftype bfq_blkcg_legacy_files[] = {
 	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.name = "io.weight",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NO_PREFIX,
 		.seq_show = bfq_io_show_weight,
 		.write_u64 = bfq_io_set_weight_legacy,
 	},
@@ -1165,8 +1165,8 @@ struct cftype bfq_blkcg_legacy_files[] = {
 
 struct cftype bfq_blkg_files[] = {
 	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
+		.name = "io.weight",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NO_PREFIX,
 		.seq_show = bfq_io_show_weight,
 		.write = bfq_io_set_weight,
 	},
