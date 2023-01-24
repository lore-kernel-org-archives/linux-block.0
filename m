Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B0C61D97
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 21:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjAXVez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 16:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjAXVex (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 16:34:53 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993FD474E1
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674596092; x=1706132092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l0vqgWg4Laq8fXDcDcvrkmwUI/JNjdn7eQg93Xfna8w=;
  b=eNS+w9ziQ13GO+E1oZuiftxgOvjmWzcbOcentbgDzjVgoWpQfPurYpHV
   AIy26P+gtHudCliuUJfWaGrliuD1HLCFWQTx4mRnyEFLnoqCsSopiriYH
   pYIB4ijXCcxUiIboM/LGZJd2bqv9rkj3MGEtiLl8w5nipj3w0hUFtbda0
   CU+v2ZdgKSh6JlY/T64t9g3lVSdzTMIJ2tb57+f+3xIKPl2NpTDpM0aJK
   DXkOHvT+BYzVspskE8NHLiTsIvfqkbFBTSXiPqFceCYMr4MLeVglWU/tQ
   Vnml6nsqaDwzicAZkxFDpooEw/k8Gh+8YLFwV8goOLDe3rwpZ9DdzI9GL
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,243,1669046400"; 
   d="scan'208";a="221734961"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2023 05:34:51 +0800
IronPort-SDR: Qg91d9VXRL+zSoxHMfO8jYMDFwK0LLWpQzmx5MNkrLG0YU/zGH54oQKUBWIf5Hdr1cAJxn5uS3
 WvZ+yZy422VBmPENSiyZWaG/rIAXGRVfORj0qdZPP366bNQOA86bnzuJ8tgFZd/cgsCCtOyUI8
 R39X2uOTcI4sl/fUog80HIasoAZjxo3mz2FEwE3canM+qQfoWuS+bf0QF0ogv18AqJnuN/5BkG
 6FU11+YpTEAIDmLr8zFEtGw7OL4SHt9DPNwy9Oiv47A4EBJW040wkgcUFV6DtMjHiU9sMe/47W
 mGc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 12:46:39 -0800
IronPort-SDR: FmhFH7jmOdBm1pIXVjaA3MXRGDV+Ek11x/GRSgVR3KvUtBxdfHEGyjIrKM+coy8BqTkYzKxLQh
 hHMlk1oe83JQCN7bpEFMM9cocSGOCmwQvIJoD8MYd07eNjL+zNk7zHk0Apadol4HUiXE1KuqIb
 D0IwCUwkgHHdKTHvk54KPgrd1yx1VxrYzrlGupIe9Jc2fybo0kx+Mzwu4ydaVufgYcLqoiA/X2
 Y0S46LAuvS/Pev2YXrvZoHz7KDLqcK2N29npRA2SWBE/yN9X/beP6/qvn0g6Z+4Fzhkjwnk6Td
 2/U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 13:34:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1gGz46sLz1Rwrq
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:34:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674596090; x=1677188091; bh=l0vqgWg4Laq8fXDcDcvrkmwUI/JNjdn7eQg
        93Xfna8w=; b=gNHEkFhju2SUU8gbS3ru3k+5YExHIA7sPsvoSQXyXkb+C9X+bvh
        Yz9SlhXkXaSNTS2EmxbmaGHqU7K1o/yPbpxCZPZlzT7xXHtTQzAKwjCG9hr/FveZ
        btCPmjGesFOdmi0d7ad6lvCw/tQ3wKv6epQryAzUD1JXDd1v+KH1TJTiYsOdn6PG
        lwJ4WbinmHLGbqKC1T9zo+9TTKOU9nG7dcV4+5OPHBMOqNO99rut9lnXWhYYkYsp
        HKQnyNvhqK/kidtMefizjpZIptlGUcHyskJJisfQrSjPunYuVZb45UpWNvD0Jhxf
        I0WMBqKZ5iwft1/ow1sFG5CnheVSmjPLQUw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4n_i6UgxlkFv for <linux-block@vger.kernel.org>;
        Tue, 24 Jan 2023 13:34:50 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1gGx4cZfz1RvLy;
        Tue, 24 Jan 2023 13:34:49 -0800 (PST)
Message-ID: <891fdc9d-ad9a-7817-01c4-87c91861eb2f@opensource.wdc.com>
Date:   Wed, 25 Jan 2023 06:34:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 02/18] block: introduce BLK_STS_DURATION_LIMIT
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
 <20230124190308.127318-3-niklas.cassel@wdc.com>
 <517c119a-38cf-2600-0443-9bda93e03f32@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <517c119a-38cf-2600-0443-9bda93e03f32@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/23 04:29, Bart Van Assche wrote:
> On 1/24/23 11:02, Niklas Cassel wrote:
>> Introduce the new block IO status BLK_STS_DURATION_LIMIT for LLDDs to
>> report command that failed due to a command duration limit being
>> exceeded. This new status is mapped to the ETIME error code to allow
>> users to differentiate "soft" duration limit failures from other more
>> serious hardware related errors.
> 
> What makes exceeding the duration limit different from an I/O timeout 
> (BLK_STS_TIMEOUT)? Why is it important to tell the difference between an 
> I/O timeout and exceeding the command duration limit?

If the device fail to execute a command in time, it will either
1) Fail the command with an error and sense data set (policy 0xf for the
time limit)
2) Return a success status for the command with sense data set telling the
host "data not available". This (weird) case is in essence equivalent to
(1) but was defined to avoid the penalty of a queue abort with SATA drives
(NCQ command errors always result in all on-going commands being aborted).

In both cases, the drive is still responsive and operational.
BLK_STS_TIMEOUT is used if a command timed-out, indicating that the drive
is *not* responding. BLK_STS_TIMEOUT thus generally mean "something is
wrong" (not always, but most of the time.

So we cetainly do not want to overload BLK_STS_TIMEOUT to indicate failed
CDL IOs as that would not allow the user to distinguished from more
serious hardware issues.


-- 
Damien Le Moal
Western Digital Research

