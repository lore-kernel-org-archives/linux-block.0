Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83D9C433F5
	for <linux-block@archiver.kernel.org>; Sat,  1 Oct 2022 00:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiJAAu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Sep 2022 20:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiJAAuY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2022 20:50:24 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317D10ED97
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 17:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664585423; x=1696121423;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GzapoAx1yyETlTo9s+u64ZXimE4706mEDDvom0JArvo=;
  b=HEr3h3CjrmbJyh12GHY+Fg94CblQB59/QticFN2mZy8OKu2pfzlsuLPJ
   vR4t3L8uTDIIUGlB3kvG45KH0ok4VDtjMpsY++MN2TCHzFE5DPEmaz7Ng
   1op8Nt/VXgoRp/sx3Xxwx5RPv8he2M1MyKmO/23rwM7CAr0h3KsAT3vAU
   eGzjKpUbQ4vJmhpO8wtsVUr/bE5gIjiauni8b9HAFVZvfPg5a3lYOKYrp
   gmo1sxoVvAChuaD385kdlj7Fky2J/KmuFmxhA9MW8aNHYUh03vZOm9XC8
   V9NY22BOCcyalkc2yP2Gx6C1FaAeQ/AlZGLSoJ7bw39/07I2TalYU3vLx
   A==;
X-IronPort-AV: E=Sophos;i="5.93,359,1654531200"; 
   d="scan'208";a="212712833"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2022 08:50:18 +0800
IronPort-SDR: OaCrPUVOENB7srfQomtwhMUwBqSwcyKDK1e8k+fmfb3vpS2a/bBPZdSwHQQB2aIFkhZ1RlyCLK
 3MaVJx28ThMb/Hv8VrrCr62d15G3k3V+f6cS7iMTQniwIbpWWYD9mGk7yybAsqxXC9aLLb+2rV
 v5Stt/XF+h09l/QDjexha6n+qkMbrhPbDqcjePzcZ12GpVq2EzAZf5XXkuwJ9fLhsN3g4H2A44
 xVXwyVS4y34UPV7qTf7wse1rygtCLLtcV4v1TI4jedkzZRP6ZBjlvD+FRzOnpLbHwEJcJxiWSk
 HKg+ml/OSo7zGHjljInw0RB/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:04:38 -0700
IronPort-SDR: L1u2+PD1Ncsji3TnLx9WnwIn3saCkVxyyU7KZmJLNEuC/URFyuYQNET34WtQNSj58/CiIN1vzb
 FK5oFwWSXLhr5+0e0nPlSpPOpRFbUj+Vs7TeewEjY6WQrx3kNEdyGW2F+tOBujSRWZWe5twSbG
 roSU8PA/yLRM/m6z3ViX25lbGKkH4PHVfGSSTeVvVgbJIBC1CJfh+bmv6G5JI52ZLewyl77zyN
 bprsDWz99pEgFtQgPPN8UMbQZ3/dVkG2ixUnO8bxOeOj/ZCSbisj6Yh4S7saM9aIGYZQnlUNze
 uHE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:50:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MfT621S5Yz1Rwtl
        for <linux-block@vger.kernel.org>; Fri, 30 Sep 2022 17:50:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664585416; x=1667177417; bh=GzapoAx1yyETlTo9s+u64ZXimE4706mEDDv
        om0JArvo=; b=jTGTZ2jMAbyGg+Hyi4828GU0d6vejPvaN1H2y7z7klKcrW/kXS/
        +xUZoRW9aMBmsnYHeLp3IcgbtssITCBs3wpmegTVgoGSR9kLxP4Xfyu6LUeXYzj/
        s6wq6efhnSZtkSdtIzjDoe5Yw/jQi+HWqvqNGCgd+EarWv+OEZ2bg3cM1E0Q1sSV
        Miz6MVkVK1auvQx5BQYv0ITEdNkClpWErvWs6LiRsvIyl+7OROmP5m2ckE+oqmSD
        xvCQnkdE0pV4BDi2jKPRcoW4lmI093KaVCrrdhmE8nhgPeJNHtpr5VlZKvOMHeyz
        6HNMYGcPIa9fK4hMR0qicS1qPns4EXd7kvg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id v0SLAYPr_W1A for <linux-block@vger.kernel.org>;
        Fri, 30 Sep 2022 17:50:16 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MfT5y5FD4z1RvLy;
        Fri, 30 Sep 2022 17:50:14 -0700 (PDT)
Message-ID: <8d5ffebe-39dc-b811-ce7c-9df4b5d061c1@opensource.wdc.com>
Date:   Sat, 1 Oct 2022 09:50:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: block: wrong return value by bio_end_sector?
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <D4FC5552-B3C8-4118-B3C8-C6BF20C793B4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/22 00:59, Paolo Valente wrote:
> Hi Jens, Damien, all other possibly interested people, this is to raise
> attention on a mistake that has emerged in a thread on a bfq extension
> for multi-actuary drives [1].
> 
> The mistake is apparently in the macro bio_end_sector (defined in 
> include/linux/bio.h), which seems to be translated (incorrectly) as 
> sector+size, and not as sector+size-1.

This has been like this for a long time, I think.

> 
> For your convenience, I'm pasting a detailed description of the 
> problem, by Tyler (description taken from the above thread [1]).
> 
> The drive reports the actuator ranges as a starting LBA and a count of
> LBAs for the range. If the code reading the reported values simply does
> startingLBA + range, this is an incorrect ending LBA for that actuator.

Well, yes. LBA 0 + drive capacity is also an incorrect LBA. If the code
assumes that it is, you have a classic off-by-one bug.

> This is because LBAs are zero indexed and this simple addition is not
> taking that into account. The proper way to get the endingLBA is
> startingLBA + range - 1 to get the last LBA value for where to issue a
> final IO read/write to account for LBA values starting at zero rather
> than one.

Yes. And ? Where is the issue ?

> 
> Here is an example from the output in SeaChest/openSeaChest: 
> ====Concurrent Positioning Ranges====
> 
> Range#     #Elements            Lowest LBA          # of LBAs 0
> 1                                               0
> 17578328064 1            1                         17578328064
> 17578328064
> 
> If using the incorrect formula to get the final LBA for actuator 0, you
> would get 17578328064, but this is the starting LBA reported by the
> drive for actuator 1. So to be consistent for all ranges, the final LBA
> for a given actuator should be calculated as starting LBA + range - 1.
> 
> I had reached out to Seagate's T10 and T13 representatives for
> clarification and verification and this is most likely what is causing
> the error is a missing - 1 somewhere after getting the information
> reported by the device. They agreed that the reporting from the drive
> and the SCSI to ATA translation is correct.
> 
> I'm not sure where this is being read and calculated, but it is not an
> error in the low-level libata or sd level of the kernel. It may be in
> bfq, or it may be in some other place after the sd layer. I know there
> were some additions to read this and report it up the stack, but I did
> not think those were wrong as they seemed to pass the drive reported
> information up the stack.
> 
> Jens, Damien, can you shed a light on this?

I am not clear on what the problem is exactly. This all sound like a
simple off-by-one issue if bfq support code. No ?

> 
> Thanks, Paolo
> 
> [1] https://www.spinics.net/lists/kernel/msg4507408.html

-- 
Damien Le Moal
Western Digital Research

