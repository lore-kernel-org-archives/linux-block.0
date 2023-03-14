Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A881C6FD1C
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 12:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjCNM2D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCNM1k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 08:27:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10D7685
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678796716; x=1710332716;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eXqhOA59lR2OsemLai44IJ7M3W9geVIWrz3XdU1LItk=;
  b=Bswd0xPd+kbo+eKzFrATv26JESkTmH/y7GD2e6LzovCNC0jL0+D/yaCM
   HEsOcfGDvnp63OA1WbwPcjbzciuNcCrWLLGhwZ2FGh/AtHiR3OiASGlGE
   gsEZpWEsGH9AQrE7RBT/kPIsOKuj5iCRNfcdSRLgta5IvIVikbYfnxhFw
   VzTA+AAHCfoHKR9+VstPKhBTwVT6N5yTvYih7v9dy59VXfGaSEVOtKV77
   k2ia8oFj/aTc5vI5PkZ3odpGB7d2F0HDRco8FnLsTSj+egbxG2MffrpV5
   RLXW7PRK8WUuGTfAfjMSVBnVAbJD7uJ4ztDOlapaDRyDE4UzvBjYtfpEJ
   A==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="337613283"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 20:22:09 +0800
IronPort-SDR: +pAhj4wU7oOxVsZsYlrOEh3dwQxp+zBVM4DLp9B2xqWD85Yv8ZMd1g5O/mACYqDWzJhwKt8XQ/
 iq0x1dbNaAD1xszbPMIwXyN2QkWqs1rWwABxtHt3wbFxKmBMQHAYJmCrXyjtoAEmQGHTYklOyL
 qoAVcGWof3iSbahrfnzWMHpUTmVGBA9lFJ8u9IrZjfVYpku0FCaWrRxTWYw72dmtIsjuxJjBel
 bgYQl0o96mXJmySfqcycABoixhMnjt7QCcWybQQdybru175IsUFEOqijDWFQ7Piy16BfmL3GVq
 PLU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 04:32:58 -0700
IronPort-SDR: 48L+Vjz0ErgHp+UAUH248OuzHjIn5M4YQa1TPwxpdVqfhxyQfl3Vgg9mtPHcw8G2NYuw5OYo3t
 qAscVKFpi7LWUeghCodcyjoDnPIVtZP1E4j1bahyJHLLhb938jfoDoIYFlytDqHFl/5qp5++GI
 YHHoSmxeFWDJNxaegC3XHFN0VnMHxAEJD5UQhIUA4+Nr6nY6UCtrhr7FhHN/4MdwwZbTLQ2i8b
 KTPPHnwyFZwkxnInS4tWbQlhQM5jdQphoEDP2tAA7OaotLeIBFIPPVroNgnk+9ehRb5E8yN1HW
 JLo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 05:22:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbXhf6Z98z1RtVt
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 05:22:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678796530; x=1681388531; bh=eXqhOA59lR2OsemLai44IJ7M3W9geVIWrz3
        XdU1LItk=; b=SS2wEdvy0eYrn/X/kFi1p337PKmpGRxSIJdp5mc00u4jm1lIyru
        TC9Y4dwO7bwg1//wMY0iUmWQLOpzC26fn8FHgJMtogRkgPA5i+a01JeSpB4qm5TI
        nHSueYA+5zTNDdX1ru9YkucoP2pTxVvjBQzarrk5qZFp9NVZ9cFk233l/L/HAJrd
        0Xumv4eEB9IStkxichCzME39OzhLMVV+hw5RFFy0LJJFzMlVlxBfxuz4lhsiek6t
        fLoyNZJIK3upGPEA8dRiQR9+x6ZOwy2eX7KxQgZHiPCiSPHofKv0Org4eGOVLV+A
        2sz1YIxQwErSRuEgDIjEnSzTD77hZFdM7zw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 41UQwcZDebsQ for <linux-block@vger.kernel.org>;
        Tue, 14 Mar 2023 05:22:10 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbXhd5Gmrz1RtVm;
        Tue, 14 Mar 2023 05:22:09 -0700 (PDT)
Message-ID: <24e54d52-e7d8-312f-8872-388d8e4c70b4@opensource.wdc.com>
Date:   Tue, 14 Mar 2023 21:22:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] block: do not reverse request order when flushing plug
 list
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20230313093002.11756-1-jack@suse.cz>
 <ZBBJ7CLOurvOO3OQ@ovpn-8-18.pek2.redhat.com>
 <20230314120900.u67czr5v4kd3my3r@quack3>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230314120900.u67czr5v4kd3my3r@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/23 21:09, Jan Kara wrote:
> On Tue 14-03-23 18:18:20, Ming Lei wrote:
>> On Mon, Mar 13, 2023 at 10:30:02AM +0100, Jan Kara wrote:
>>> Commit 26fed4ac4eab ("block: flush plug based on hardware and software
>>> queue order") changed flushing of plug list to submit requests one
>>> device at a time. However while doing that it also started using
>>> list_add_tail() instead of list_add() used previously thus effectively
>>> submitting requests in reverse order. Also when forming a rq_list with
>>> remaining requests (in case two or more devices are used), we
>>> effectively reverse the ordering of the plug list for each device we
>>> process. Submitting requests in reverse order has negative impact on
>>> performance for rotational disks (when BFQ is not in use). We observe
>>> 10-25% regression in random 4k write throughput, as well as ~20%
>>> regression in MariaDB OLTP benchmark on rotational storage on btrfs
>>> filesystem.
>>>
>>> Fix the problem by preserving ordering of the plug list when inserting
>>> requests into the queuelist as well as by appending to requeue_list
>>> instead of prepending to it.
>>
>> Also in case of !plug->multiple_queues && !plug->has_elevator, requests
>> are still sent to device in reverse order, do we need to cover that case?
> 
> That's an interesting question. I suppose reversing the order in this case
> could be suprising e.g. for shingled storage. I don't think it matters that

We do not allow plugging writes to sequential zones on zoned block devices. The
reason is that write commands in the plug may end up being reordered with write
commands issued later but without plugging. We hit that issue while doing btrfs
work and the only easy solution we could think of was to not plug any write
command so that the write ordering is preserved down to the scheduler insertion.
For the dispatching order, it is the scheduler (mq-deadline) responsibility.

> much for normal rotational storage as there you presumably run with at
> least some IO scheduler (we were using mq-deadline in our testing).>
> Avoiding the reversal will require small changes to plug handling (so that
> we append the plug list) but it shouldn't be too bad. Still I'd do it in a
> separate patch.
> 
> 								Honza

-- 
Damien Le Moal
Western Digital Research

