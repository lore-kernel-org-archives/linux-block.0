Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915BDC2D0E4
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0C12076B
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD5EsTFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgKXOGY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728076AbgKXOGY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 09:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606226783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eBO0SmdWfHJMWvxPw/zFAYNKqN9n70rfpX1FzfBSls=;
        b=AD5EsTFqDWliNVEZUFE0dtk1JBXstYFLUfSLl7dt/xaZs+I9w1BxxLSrUUXL84PIweeewm
        t0lmDWu+Dt870e18bpw4pAfo6nPavzmGe9d0zeXcwzG3fj/6uXXY2vUmcTwE1HHmsTl/WV
        9Q25JM6ET6d02KjrtXuivBswpEwGXlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-Ms0u1oPmMgWE_clDbbFA-Q-1; Tue, 24 Nov 2020 09:06:17 -0500
X-MC-Unique: Ms0u1oPmMgWE_clDbbFA-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1AC0B8105;
        Tue, 24 Nov 2020 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B4BC60864;
        Tue, 24 Nov 2020 14:06:13 +0000 (UTC)
Subject: Re: [PATCH blktests 3/5] tests/nvmeof-mp/012: fix the schedulers list
To:     Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-4-yi.zhang@redhat.com>
 <241aba9c-b57b-e81a-63b9-d79a3178d946@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <7da7adbc-1831-a4e3-805c-a72649893309@redhat.com>
Date:   Tue, 24 Nov 2020 22:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <241aba9c-b57b-e81a-63b9-d79a3178d946@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/24/20 11:28 AM, Bart Van Assche wrote:
> On 11/23/20 5:04 PM, Yi Zhang wrote:
>> There is no cfg scheduler and new added kyber scheduler in lastest kernel,
>                ^^^
>                cfq?
Thanks.
>> so get the scheduler from sysfs
> [ ... ]
>
>>   	# Load all I/O scheduler kernel modules
>>   	for m in "/lib/modules/$(uname -r)/kernel/block/"*.ko; do
>> @@ -17,15 +17,17 @@ test_io_schedulers() {
>>   	for mq in y n; do
>>   		use_blk_mq ${mq} || return $?
>>   		dev=$(get_bdev 0) || return $?
>> -		for sched in noop deadline bfq cfq; do
>> -			set_scheduler "$(basename "$(readlink -f "${dev}")")" $sched \
>> +		dm=$(basename "$(readlink -f "${dev}")") || return $?
>> +		scheds=$(sed 's/[][]//g' /sys/block/"$dm"/queue/scheduler) || return $?
>> +		for sched in $scheds; do
>> +			set_scheduler "$dm" "$sched" \
> Similar code occurs in tests/srp/012. Please introduce a function for
> retrieving the scheduler list and also update tests/srp/012.
OK, will add below function and update both nvmeof-mp/012 and srp/012

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index d0fec6f..d156a12 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -326,6 +326,18 @@ set_scheduler() {
         fi
  }

+# Get block dev scheduler list
+get_scheduler_list() {
+       local b=$1 p
+       p=/sys/block/"$b"/queue/scheduler
+       if [ -e "$p" ]; then
+               scheds=$(sed 's/[][]//g' /sys/block/"$b"/queue/scheduler)
+               echo "$scheds"
+       else
+               return 1
+       fi
+}
+

> Thanks,
>
> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

