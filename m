Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E434C678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 08:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCBITf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 03:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCBITe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 03:19:34 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E61A974
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 00:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677745164; x=1709281164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KKyEdtNDOhebKEQjj/Qmh1erCfjwM0PsZRUXNGv/4xM=;
  b=VfVqnOx53pQPqaYBxrN95V/ZKIg3vLbgrKeQGP5fSTdn6T3fVi2sZ0ev
   3ylwFqSHVoZAf781lsAX3GRqp1KEglzpsSWCpL3vbzuF132xrZixJTxkk
   FFgzRRiiwbbdAQ2dao+C8uqzZ8Fh8uEM5eToBzbfRhrf3Y22030vZlXVZ
   STr6v9c69wCnCSyu+Jc07tzY7o29231Qn0HBd//JVmzb2PzWL2LwkDDSe
   uwADSbEGG6argqwnB+sJjOrARXRpl3gMAnFcF2ft5MkJ8tOGaA7rjSIm0
   GmV4RXVI19wOoFgmOebaoXneYAQaY3iVodTm/JkrFhVEDulsObRKOQCz3
   A==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224390336"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 16:19:23 +0800
IronPort-SDR: +LjzONhhW0a412O24bX5u7GgR1TFhADaCNzHxm3tsFfQWtPXb+q+Ina4bsWRQNYl88HQzHvNK3
 7K/kccYZkfZXf04aybvWuZMp3vFMvu4Lh4FVv8x9kKiZ3dl5KnSQdGnqbuL7raytX0EDl6+SBs
 DokGGVMQ0ltk/k5zSSnUM5HC6KslYIbhlpgsWdCdVQHfUIqbGshqsStkNX0OXIJIeNUECp4SZ4
 HizbavvMy7STgqJy6tRbkmzMS/ybXkmm1KFEOAlgoiOvKPFRDR5a5G/rMU0OktZPUQ+dtTnCGk
 wvo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 23:30:28 -0800
IronPort-SDR: iVDBEeNwqdhw/S3n8bMTSLNBPbojQbjY9qLn3Ny0ZmK7Do6hVixEtIeriNQZF0wYZFeK04duPs
 gWKU9qrs+u6Ui8FCnyKgAZf+fFvsdYcekwc1NdzAZ5pjkL10uZFxUnCrQOrk01T7HQPwrLlSH7
 ubNZpdaIml/97QeaymWsnsQC8KEhrvFuP//ST5a28lQCSe2tpvTHAVZEOHnyC8Pkx+5TuGJAg5
 up4CzY4BGLJ5Am8+7nLJxBUIuVfn6uac8HndmMBquqVB6AM4DVFOFEzq+owyCYkHqP36Ni9hQ2
 1rk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 00:19:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PS3t34hZLz1RvTr
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 00:19:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677745163; x=1680337164; bh=KKyEdtNDOhebKEQjj/Qmh1erCfjwM0PsZRU
        XNGv/4xM=; b=mB50Sf+llKHkJMt2P6iQ54lvHazfPTk3E14GwdXQZ76Dt5TeIfy
        Xhgf3q8XToFWxnX+uuq3NQWieTZy3ayXjXTbVhmOVaq9VDdMJINmFuWJwxMKscu4
        380mtcNlv8B/6LQe/gdlkN8NVNCjkpjs7Q4h6gbfWnR+JXAAD97ngo8r95Os8LsF
        rWLti251f9BjnClZqh4N6I2MzGKE5FnDnpUPetdNgwkrCUfjeOvmXfcbSl/uEmID
        IpVFZP/A2mdwwOjH5xH5lwqLYrbGMeNBQFQqF2gDnQGVOxU5OXakJ/ijVq81bo7Y
        Hs6bPxEgMOOuyA8XcAMvl+SyrJHyOWMfqVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id k_LHVnt8siwR for <linux-block@vger.kernel.org>;
        Thu,  2 Mar 2023 00:19:23 -0800 (PST)
Received: from [10.225.163.47] (unknown [10.225.163.47])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PS3t15fGpz1RvLy;
        Thu,  2 Mar 2023 00:19:21 -0800 (PST)
Message-ID: <0d0e5c63-a155-d2ad-1829-c016c61acad6@opensource.wdc.com>
Date:   Thu, 2 Mar 2023 17:19:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Content-Language: en-US
To:     Andreas Hindborg <nmi@metaspace.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
References: <20230224200502.391570-1-nmi@metaspace.dk> <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <87o7pblhi1.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/23 16:31, Andreas Hindborg wrote:
>>> +struct ublk_param_zoned {
>>> +	__u64	max_open_zones;
>>> +	__u64	max_active_zones;
>>> +	__u64	max_append_size;
>>> +};
>>
>> Is the above zoned parameter enough for future extension?
>> Does ZNS need extra parameter? Or some zoned new(important) features?
> 
> @Damien, @Hans, @Matias, what do you think?

Yes, add some reserved fields. The struct is 24 B for now, you can make it 32 B.
But it is a little odd: why 64 bits for max open/active zones and max append ?
bio len is 32 bits and number of zones also 32 bits. You do not need 64 bits for
all these fields. Also, no zone model reported with this ? What about write
granularity (for SMR HDDs) too ?

So something like:

struct ublk_param_zoned {
	__u32	model;
	__u32	write_granularity;
	__u32	max_open_zones;
	__u32	max_active_zones;
	__u32	max_append_size;
	__u8	reserved[12];
};

looks better to me. Note sure about the need for model and write_granularity
here though. I did not follow zoned ublk patches.


-- 
Damien Le Moal
Western Digital Research

