Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE32C38142
	for <linux-block@archiver.kernel.org>; Sun, 29 Jan 2023 02:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjA2CFi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Jan 2023 21:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjA2CFh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2023 21:05:37 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B518AA9
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 18:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674957936; x=1706493936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lMWivxvLhEfQDKorNEnMNpMAFprd1R9pddYdWXMbzJo=;
  b=jFQAUZd64dsMroAgu4CRDWw91VQEcyWtzYkMIOc40b+fEbsvu3TNMI/M
   8vZVzarf7GvUvxvjUxmOhfEz28Jl01kBuqzIV3rC0hCBVyz1gQQMZR9vQ
   Rpp0GH9epoytp3em9iOqN2B1WfT27jP8cIASy9pmsKTY0zVr5vWrCcZUg
   MnnHGBZus78tT/kcnaj6aMpOnQni3eywkaSRArNQQNLdtq6GSPgmIhph9
   frGulrnyYRM4O6/6B5TOxZcJM55OIl3h5uCUP/rg6A2bDtV/O2i6/FTwH
   nEZpKJFNavPaIo4h3QF6fK331ZX3w8sJ5HUZx2LcDUUakAC2H8zFyihFZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,254,1669046400"; 
   d="scan'208";a="326286263"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2023 10:05:35 +0800
IronPort-SDR: a+u/Q4QdmsMVdBZ2H0HD+lM9JqUOQusf1UpU7WTUB5IjQWNkDJP7q5zZVSQZkUe5y8gj9aupU7
 9qCKPZRwiE2PwFAD/3Ms+5eGD0MSKHBI1nx7XwwDHWr4iAHMMGLITZN8H8w78A/Xx5k5L21yqm
 6tZpcPdW7EzJG1YE9QRU9tqIT94ZMWhXbzWb/6AX3TV8p41J9QbJ8ZO+1S662FXA3oOdI9i+jl
 QssBwlyCaotiFR0U5xCDqEaUJP5Zi5krBnrECTVoljuLxS1T+t9aQfdnrDLP+ik9U+KLWZDx1T
 oAo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2023 17:23:03 -0800
IronPort-SDR: wP09Zd/6BOuzetxF5Z1Gnb4H+amwzZr7Dv92Q3QARL4PuzlBToRG2bqRjMUVLTw6f9VgwBw3aX
 oTFap+bWYrE7Wiz7eRucr0hZnCZm9LtWcgLXmQ+7coS54MnewmEEiu7MZGt4Sq3qQALLisYcWI
 WN2zEcjJe6D2q65pM+3uaM3J6ZR8fz2dFUFeOfxIFRTqj4Y6gpx/tYzDA8eyZZ+IVhQOng8moD
 31Pwtn81w/yN42sO0Ol15tb+5kMHYTs3aJ7lPMYaabCgf72GKb5pace0rJET2vsDLJRpstnNrn
 Jps=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2023 18:05:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P4F5W2QXGz1RvTp
        for <linux-block@vger.kernel.org>; Sat, 28 Jan 2023 18:05:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674957934; x=1677549935; bh=lMWivxvLhEfQDKorNEnMNpMAFprd1R9pddY
        dWXMbzJo=; b=ec2bLH+IUZYrP+pzBBc80pTKaFoRH8Q2df9F5NJBguMTqwFuPFh
        ThGxVPOqe8XBeW/MxwjeVfMmWw85ulzOL2mcfCDFPs+pKvEpv3nke9fnMA0Q+hke
        KHZfFNEfJoMvWLuJo0CJt5/6CbFDUqrInjKV1cUg3fU0Ir83XfD/RhoBmxQeDqJk
        uJxXCvxkJ94XhOgxmxyGR6Jgc2IDU9dwpLubAO+elu6F6zh9KYOhHAu+baOLf0mW
        8Uq/meSrcxfa0v9XqPpu91I7E94ad8FxkVaZlpbHakuBeYulW1cfvXdx3tAC1KlE
        IVqBf8YxKQvjBG40YffhJLn3PIHFQRRIALg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pKc4F7KAkCmn for <linux-block@vger.kernel.org>;
        Sat, 28 Jan 2023 18:05:34 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P4F5T1WtTz1RvLy;
        Sat, 28 Jan 2023 18:05:32 -0800 (PST)
Message-ID: <976c4854-2c98-15f8-12bf-ee08ab86af96@opensource.wdc.com>
Date:   Sun, 29 Jan 2023 11:05:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 07/18] scsi: sd: detect support for command duration
 limits
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org
References: <20230124190308.127318-1-niklas.cassel@wdc.com>
 <20230124190308.127318-8-niklas.cassel@wdc.com>
 <f0793325-3022-e7b8-672d-00f2f9ee0cd9@suse.de>
 <99e6b267-6e2e-2233-19c2-1acf7c9135b2@opensource.wdc.com>
 <f9fe4e54-563a-c8fa-23ae-88780c4edc54@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f9fe4e54-563a-c8fa-23ae-88780c4edc54@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/23 11:52, Bart Van Assche wrote:
> On 1/27/23 16:51, Damien Le Moal wrote:
>> On 1/27/23 22:00, Hannes Reinecke wrote:
>>> Hmm. Calling this during revalidate() makes sense, but how can we ensure
>>> that we call revalidate() when the user issues a MODE_SELECT command?
>>
>> Given that CDLs can be changed with a passthrough command, I do not think we can
>> do anything about that, unfortunately. But I think the same is true of many
>> things like that. E.g. "let's turn onf/off the write cache without the kernel
>> noticing"... But given that on a normal system only privileged applications can
>> do passthrough, if that happens, then the system has been hacked or the user is
>> shooting himself in the foot.
>>
>> cdl-tools project (cdladm utility) uses passtrhough but triggers a revalidate
>> after changing CDLs to make sure sysfs stays in sync.
>>
>> As Christoph suggested, we could change all this to an ioctl(GET_CDL) for
>> applications... But sysfs is so much simpler in my opinion, not to mention that
>> it allows access to the information for any application written in a language
>> that does not have ioctl() or an equivalent.
>>
>> cdl-tools has a test suite all written in bash scripts thanks to the sysfs
>> interface :)
> 
> My understanding is that combining the sd driver with SCSI pass-through 
> is not supported and also that there are no plans to support this 
> combination.

Yes. Correct. Passthrough commands do not use sd. That is why cdl-tools triggers
a revalidate once it is done with changing the CDL descriptors using passthrough
commands.

> 
> Martin, please correct me if I got this wrong.
> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research

