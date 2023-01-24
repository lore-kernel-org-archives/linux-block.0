Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE46C54EED
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 21:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjAXVjm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 16:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjAXVjk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 16:39:40 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9AB46702
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674596375; x=1706132375;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qd6GlOwYoybiib2oWiWQIX1FOUfCwCEdPWZivN6s5lw=;
  b=A/VKCd2ikj9h7cD9KRxZLLt8BpZfztYuUgxvtimu/RWcv/YFpERfPHw+
   ZaaJcLFtYxJaYytLthj0APhosWtAJ4RqwxLWw2lGY0FmuHHejE5+22If9
   Bu9RUcpp8SUivyjh1+UsixmuSuv3MiVSQEaeJMyiHJfGXD0l+CAw2Thi2
   AXyefFlVrJui0KtOpQ3BcF4e5mDfOytopm0Ohn9KYX5qUulJxSwxr6MeH
   qadoWjMBSoucyzD/vY1+2W48uJXAdFxhXoWWyJQGoShdP98UKJTCkcoIH
   plHYn0pVho43LTQwM+k1L79A5LgGAxGzo6JZWBmounUBvhBhhCtfJa5tT
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,243,1669046400"; 
   d="scan'208";a="221481301"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2023 05:39:35 +0800
IronPort-SDR: 3Wk/gYFjtxUqLSiPe7zzTYXkIre1H70dm9YQ9L9JiO2vU3+s3vLxWTcYP06c2KWeGRJjywBBAw
 5pzZx1p3tGNXt6vnN6Ph08k1dZEOP89g4+UR7nFOPd1AUP0Bhzxlc+ueTw6BPSPLTUc1+GXBvc
 ibzqHpd49t7DOvPh3TrqWMmMQ78ULduklg3W3s6UpsG4dDFZMAqe7CNWORYaRTj+vT+bkpMqq9
 dx+n3TZbi9GL+hEnMJf79FkihXlzWJGVuugq4R64VXe5tPeupBDEQE3UJTxbMGr9b7P+XdxkxL
 sL4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 12:57:07 -0800
IronPort-SDR: 9TUea4SvpNcmuZcPxFnx6EtfwgP4xgZai3GQ52ZRdJjLQFzXLeEVKlKNFE1TSBKaBeBrOBZSCY
 8gL94SlduhrxYK6axWGlq2oC+xfz/rEWtwmryoFkcoTB+NGi7nuIpFr4uV15sEdzb0aa3MSK/S
 kvvWgc+yTQFxaxBIR8EKO0UGAKUkG72JqELG4ejeaUQ7XnYyXTAs09ABGtH/+ri1OOC+cJjmSf
 sqqo7SStK+Ir3jf20PXyRdgbbRSDF7Q6JJ/mT5fVuOb9or1/gvctG7adJ/7aEdqmUcGlHnyE2q
 zpQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2023 13:39:35 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P1gNQ6l92z1RvTr
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 13:39:34 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674596374; x=1677188375; bh=Qd6GlOwYoybiib2oWiWQIX1FOUfCwCEdPWZ
        ivN6s5lw=; b=E1yAk+97ZRJTqcpSwJiNQYoRCvTkJZ4HWeX2uA/mv2k0YibOtMd
        1Kc/S5m4H+rL1CkjeO05UxH88uUEKagj6AFGCSjGHf+meS6nuR0VJINKol2s4GNh
        vBza/2XOEEMNkelPLGW7/egYOLDreDJKkL5CVGLD1JAN5xhRnSNVzRVX8UvLe3m6
        uuJvo+wfLeYKYNy+HcBbETWJIpY00wUPkMWRK/C5mh5W+evxJsq51z2yLP0FvjfQ
        Qs9dRGI2uIqoqbcAiUxf3ToJDJpTArfQ84cOAAvhpXJMerNhWnFdx83kS6jjeQyi
        /mjZ1K3Peh5OL5H/DAdob+BTs9H6T7ZQSQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uq5aqVaN0Bw8 for <linux-block@vger.kernel.org>;
        Tue, 24 Jan 2023 13:39:34 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P1gNN3q95z1RvLy;
        Tue, 24 Jan 2023 13:39:32 -0800 (PST)
Message-ID: <542987b0-c4c0-6ed7-b950-84faee0a2e55@opensource.wdc.com>
Date:   Wed, 25 Jan 2023 06:39:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 02/18] block: introduce BLK_STS_DURATION_LIMIT
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
 <20230124190308.127318-3-niklas.cassel@wdc.com>
 <517c119a-38cf-2600-0443-9bda93e03f32@acm.org>
 <Y9A4s5tlsdx0S8s4@kbusch-mbp.dhcp.thefacebook.com>
 <a127b2d1-b7b0-66e4-5af1-bd292a46e752@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <a127b2d1-b7b0-66e4-5af1-bd292a46e752@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/25/23 05:32, Bart Van Assche wrote:
> On 1/24/23 11:59, Keith Busch wrote:
>> On Tue, Jan 24, 2023 at 11:29:10AM -0800, Bart Van Assche wrote:
>>> On 1/24/23 11:02, Niklas Cassel wrote:
>>>> Introduce the new block IO status BLK_STS_DURATION_LIMIT for LLDDs to
>>>> report command that failed due to a command duration limit being
>>>> exceeded. This new status is mapped to the ETIME error code to allow
>>>> users to differentiate "soft" duration limit failures from other more
>>>> serious hardware related errors.
>>>
>>> What makes exceeding the duration limit different from an I/O timeout
>>> (BLK_STS_TIMEOUT)? Why is it important to tell the difference between an I/O
>>> timeout and exceeding the command duration limit?
>>
>> BLK_STS_TIMEOUT should be used if the target device doesn't provide any
>> response to the command. The DURATION_LIMIT status is used when the device
>> completes a command with that status.
> 
> Hi Keith,
> 
>  From SPC-6: "The MAX ACTIVE TIME field specifies an upper limit on the 
> time that elapses from the time at which the device server initiates 
> actions to access, transfer, or act upon the specified data until the 
> time the device server returns status for the command."
> 
> My interpretation of the above text is that the SCSI command duration 
> limit specifies a hard limit, the same type of limit reported by the 
> status code BLK_STS_TIMEOUT. It is not clear to me from the patch 
> description why a new status code is needed for reporting that the 
> command duration limit has been exceeded.

As explained, this allows differentiating the "drive gave a response"
(BLK_STS_DURATION_LIMIT) from the "drive is not responding" case with
BLK_STS_TIMEOUT. We took care of mapping BLK_STS_DURATION_LIMIT to ETIME
(timer expired) for user space too, to not overload ETIMEDOUT used with
BLK_STS_TIMEOUT.

We can certainly improve the commit message to describe all of this in
more details.

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

