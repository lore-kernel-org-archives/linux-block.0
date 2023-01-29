Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBED5C61D97
	for <linux-block@archiver.kernel.org>; Sun, 29 Jan 2023 02:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjA2CDf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjA2CDf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2023 21:03:35 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E6218AA9
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 18:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674957812; x=1706493812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pgP9dGv/7HefR5zcDi5KT6z3WySDMJ9u8/jMVJF6zaM=;
  b=AUHYAFLUJD5FqH9aY38UVbXSr5FAoJciblWRD3AGyZ5wSBA8byAdqxkm
   p5N5156BJQyUfFLuroiL4eiUolaM0Mf50O6mNO2mHULzCck7HvaIQM8AA
   hbPt5LyxQspt9XpDUtNOpxNQWblz1OOS9Ur2r9d18TN+kVwMynVPdIDL5
   2T8A3sAN+rbIZZNMl/U+/fReIPqIf7ZIWpJgdhFIWjXRlJxzSGtrfVF5N
   bBDmwd63aj6C1SBFMKjCEGrSK4k4xQ57Bt6ybjvnDZBDdctm2WuNlSZRm
   I6zAj41Awi0zY2OSapLSQeM0opcRNkzfsB2SSfiPO26+aZMVfYyCGBL9s
   A==;
X-IronPort-AV: E=Sophos;i="5.97,254,1669046400"; 
   d="scan'208";a="221792504"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2023 10:03:31 +0800
IronPort-SDR: 21BBPtay1pleeO8BR2Fi0A8NWauku3gTcNqsOwS6vhIOn9like0io0xXak9Ztq/x/do3h5xewl
 l2JrLLTNfwvMtI+gkkUChfuSdvnV3l95VwRK2SWGo0xgEmWPRrpbrx/QRzQb90bxxSO0k5yves
 M69Q+NA+VuLQbm9QBNSLdPACiWS/yGgV+P4iJoua3SafuW4ZNJi9uDbk388G1lTz9l+Lxl5CxJ
 ++0RScha7nxo5gCYVu5NVa1TjvJwQcZ6h0A7FFUfP3Z11mKGHPvsvcy2jPpJWggv9N1Xb54Aig
 w4M=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2023 17:20:59 -0800
IronPort-SDR: W2SDT7a1dYml4qN8CtX4irOPrsBXbmitWqJz1h/Wr2VzaT+Sh2fdNNi3UnrT2kNdaGwvAnbHUB
 r5dACiifk3/cPsvvuBcQlWXFf1IEMwsWFivRb5Zopb33F4uJZ+oYMRfA9LOG9jfdgk6uN24WzS
 lazIpZ80nPTU0iJCKpM+PGAZOF9iqiVEdaFTXqbG52Lz5ms62RO83Smqnw1bsrjEWRHfSP2msx
 I1eRf9aKfCZSZxmiOr4HCQYAmuS7RwqHiYunK1wGMOc3FjTshVmdSz/rPkx3J44jBMcb1oSGcz
 4l8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2023 18:03:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P4F366DKvz1Rwrq
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 18:03:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674957810; x=1677549811; bh=pgP9dGv/7HefR5zcDi5KT6z3WySDMJ9u8/j
        MVJF6zaM=; b=fTjSREUjv2NTaHZ4tgZURFgi04QQqO8/pp4l2Qm25t0PRC8gpYn
        wubHHPvW35U0JjKR1jGM//pXoWWnGaDBWwGMi4tbg4gon4cXmU5EFQqSPDBukDaO
        0wfVODPsGBFT2HeTw+NAiI/SzPZbF/kge4LbSgFITdr1L82QsisgqVfy/gWtT1QO
        HziX2ctOhX572j2n8rqS5+UWhWI8UOAigfaS3EJkzyWDFup0BPmnGxsQKmX/X4Ee
        SCr1E79zUHzdSA6l0Dy9X1SW1LlBZ7UkH3FDo3F78C09U6mawu6p73zG15hS/8jm
        nj9wdPyne5Ze5Jo0LuykokKtkJ5biMb0h/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FuKFsH044jEs for <linux-block@vger.kernel.org>;
        Sat, 28 Jan 2023 18:03:30 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P4F3535Byz1RvLy;
        Sat, 28 Jan 2023 18:03:29 -0800 (PST)
Message-ID: <66b9601f-148e-3954-036b-b053d2d04316@opensource.wdc.com>
Date:   Sun, 29 Jan 2023 11:03:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] null_blk: Support configuring the maximum segment size
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20230128005926.79336-1-bvanassche@acm.org>
 <ff478889-7a02-135f-57b6-f56d386d7065@opensource.wdc.com>
 <beafab98-df34-8f1c-1108-7e61080a7e21@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <beafab98-df34-8f1c-1108-7e61080a7e21@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/23 11:48, Bart Van Assche wrote:
> On 1/27/23 17:18, Damien Le Moal wrote:
>> On 1/28/23 09:59, Bart Van Assche wrote:
>>> +	WARN_ONCE(len > dev->max_segment_size, "%u > %u\n", len,
>>> +		  dev->max_segment_size);
>>
>> Shouldn't this be an EIO return as this is not supposed to happen ?
> 
> Hmm ... the above WARN_ONCE() statement is intended as a precondition 
> check. This statement is intended as a help for developers to check that 
> the code below works fine. I'm not sure how returning EIO here would help?

My point was that given that null_transfer() is called like this:

	rq_for_each_segment(bvec, rq, iter) {
                len = bvec.bv_len;
                err = null_transfer(nullb, bvec.bv_page, len, bvec.bv_offset,
                                     ...);

len should never be larger than max_segment_size, no ? Unless I am missing
something else...

> 
> Thanks
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

