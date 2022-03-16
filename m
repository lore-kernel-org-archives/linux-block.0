Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12979C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 11:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349769AbiCPLpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbiCPLpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 07:45:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813A362D3
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647431045; x=1678967045;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PdV9UxK6PmHCCzOX6g9P8eVdwqPH4qT3bhTy/o7cQ2I=;
  b=EaWsv/1OCsg5Ckj24PAjz7yJPpcboGcdbpFDtCWT2N+MIpy6XyFeTocR
   AkwZ1vcjTp21J18kKgALVkRkENJnBJ95ZeaFN2jaBuXKcgbFJa8Vc4e1B
   4ISf2htMPIgtADBvlRmTHiySeJB7AzXM71+QP89kdFRxk3LTy2AyncHOG
   asaaBl8PleyKahdNqs7Q1HngR4Z9M7q5CTwgAufSvF85sC5UfYi95r/zW
   eqIj5BxGFGa8gQVkl7/jeebyiN+RghD9gwoDVEnHeKs82dTANKQMTNnFw
   cDL0bYQuF0G/v6E73ZD6c3Quc1mkqVUxaTgHboC2SK4ofBOtm9vazizIq
   w==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643644800"; 
   d="scan'208";a="299647705"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 19:44:04 +0800
IronPort-SDR: tpdBDhWfh7HiOxpAT4IRDLHVn8TfhcdgzqBfFECKfOzsonupzPLDArUXREv0JLNx5RtxnDrgk3
 83gOSvzGjMxDTfYWTa5zkhTBMd5TXz0vNZamMGprd29Ygy1rN9AgET46FVIfCVHfIip7LbeEag
 Q/IMesupfm8BP4W7b+mdFllaVSESyGTrZfdlGZimWpivOaGP6yhJftrpBZUM2Ulynpr3sdrZ9u
 lECEYYEBQwMVOU7s9PUMrxvOSP/mM71Ux48TnRWWZgfx/dJlTNv2DtuDe3HcOWiVeb3yIdTu3i
 0Jww1WaLcZuZ76aR9xbI/VDR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:15:11 -0700
IronPort-SDR: 9naoyONwr/jKHbZZh54h1rhciXPT8XRoUwY+df3gSaiawiHcv1bvOpW/lO7R6470moSiYUryUj
 ovDfgpZYgpHz6TnwULi52v3GSQ/9pIkyftp4+naQXC4lo+950SegVq9gRqynJoO2aGAvMZy/Op
 VaEXbHCSjc3Qz1IPZTXU1ELOqWJ8xzfJ6JEmxPLp5s0sT3uYE2lxUIhBH5NC+CodIjH6APJyNK
 kZGANzbP2jY7iiW06uqGVpW4O2Bym1ADJp8shPfLQTR8ma8gVUo0TNcwbPxd7i3VFaSojhVTNs
 q0Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:44:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJT2D2ZySz1Rwrw
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 04:44:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647431043; x=1650023044; bh=PdV9UxK6PmHCCzOX6g9P8eVdwqPH4qT3bhT
        y/o7cQ2I=; b=N4V7WDXyj/wMC9HgjC9lduq/GJilDfgI3JgxEB8dydre95OoqwI
        rlDlXMDr83zUcxJpcGcpy+LUMPrSCPQydvtrZ1h+yhwRtllLyFyf60UBTXR3ouJk
        ZAUpT6lPoTHKIuxu4T/7RUmiLELVFmo/ayPVxWFhmoL0OyVdsgJzrv8vU5LpXOnF
        2rLx+RcYDTmaCat7qVfpyw2z2fuXdMlAcPmTW63AEnvoNhbD9xwcYKa89f+06LFe
        bJmQkfP11dK9p31zFRpNl94Dj/QWe8PxRa7aE1kLQ7e8aSRe9UFejdmIDdC6TGQ1
        RZ3JKb+K9yMpv2zkp15YMnLJ9tm9HS15VjA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QwY2GBnd9fnz for <linux-block@vger.kernel.org>;
        Wed, 16 Mar 2022 04:44:03 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJT2B0Bv0z1Rvlx;
        Wed, 16 Mar 2022 04:44:01 -0700 (PDT)
Message-ID: <0015ea51-b3e9-924a-2714-61b159fc7b98@opensource.wdc.com>
Date:   Wed, 16 Mar 2022 20:44:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <202203132219.59100.linux@zary.sk>
 <68e572f6-e1b6-8d04-900d-8621f607f3bc@omp.ru>
 <202203161228.05700.linux@zary.sk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202203161228.05700.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 20:28, Ondrej Zary wrote:
> On Wednesday 16 March 2022, Sergey Shtylyov wrote:
>> Hello!
>>
>> On 3/14/22 12:19 AM, Ondrej Zary wrote:
>>
>> [...]
>>>>> The pata_parport is a libata-based replacement of the old PARIDE
>>>>> subsystem - driver for parallel port IDE devices.
>>>>> It uses the original paride low-level protocol drivers but does not
>>>>> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
>>>>> behind parallel port adapters are handled by the ATA layer.
>>>>>
>>>>> This will allow paride and its high-level drivers to be removed.
>>>>>
>>>>> paride and pata_parport are mutually exclusive because the compiled
>>>>> protocol drivers are incompatible.
>>>>>
>>>>> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
>>>>> chip).
>>>>>
>>>>> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
>>>>> drivers - they don't handle non-multiple-of-4 block transfers
>>>>> correctly. This causes problems with LS-120 drive.
>>>>> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
>>>>> or 8-bit mode is used first (probably some initialization missing?).
>>>>> Once the device is initialized, EPP works until power cycle.
>>>>>
>>>>> So after device power on, you have to:
>>>>> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
>>>>> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
>>>>> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
>>>>> (autoprobe will initialize correctly as it tries the slowest modes
>>>>> first but you'll get the broken EPP-32 mode)
>>>>>
>>>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>>> [...]
>>>>> diff --git a/Documentation/admin-guide/blockdev/paride.rst b/Documentation/admin-guide/blockdev/paride.rst
>>>>> index e1ce90af602a..e431a1ef41eb 100644
>>>>> --- a/Documentation/admin-guide/blockdev/paride.rst
>>>>> +++ b/Documentation/admin-guide/blockdev/paride.rst
>>>> [...]
>>>>> diff --git a/drivers/ata/pata_parport.c b/drivers/ata/pata_parport.c
>>>>> new file mode 100644
>>>>> index 000000000000..783764626a27
>>>>> --- /dev/null
>>>>> +++ b/drivers/ata/pata_parport.c
>>>>> @@ -0,0 +1,819 @@
>>>> [...]
>>>>> +static void pata_parport_lost_interrupt(struct ata_port *ap)
>>>>> +{
>>>>> +	u8 status;
>>>>> +	struct ata_queued_cmd *qc;
>>>>> +
>>>>> +	/* Only one outstanding command per SFF channel */
>>>>> +	qc = ata_qc_from_tag(ap, ap->link.active_tag);
>>>>> +	/* We cannot lose an interrupt on a non-existent or polled command */
>>>>> +	if (!qc || qc->tf.flags & ATA_TFLAG_POLLING)
>>>>> +		return;
>>>>> +	/*
>>>>> +	 * See if the controller thinks it is still busy - if so the command
>>>>> +	 * isn't a lost IRQ but is still in progress
>>>>> +	 */
>>>>> +	status = pata_parport_check_altstatus(ap);
>>>>> +	if (status & ATA_BUSY)
>>>>> +		return;
>>>>> +
>>>>> +	/*
>>>>> +	 * There was a command running, we are no longer busy and we have
>>>>> +	 * no interrupt.
>>>>> +	 */
>>>>> +	ata_port_warn(ap, "lost interrupt (Status 0x%x)\n", status);
>>>>> +	/* Run the host interrupt logic as if the interrupt had not been lost */
>>>>> +	ata_sff_port_intr(ap, qc);
>>>>> +}
>>>>
>>>>    As I said, ata_sff_lost_interrupt() could be used instead...
>>>
>>> It couldn't be used because it calls ata_sff_altstatus().
>>
>>    And? That one used to call the sff_check_altstatus() method (which you define)
>> even before my patch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata.git/commit/?h=for-next&id=03c0e84f9c1e166d57d06b04497e11205f48e9a8
> 
> OK, I was probably confused by ata_sff_check_status which uses ioread directly.
> 
>> [...]
>>>>> diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
>>>>> new file mode 100644
>>>>> index 000000000000..f1ba57bb319c
>>>>> --- /dev/null
>>>>> +++ b/include/linux/pata_parport.h
>>>>> @@ -0,0 +1,108 @@
>> [...]
>>>>> +static inline u16 pi_swab16(char *b, int k)
>>>>> +{
>>>>> +	union { u16 u; char t[2]; } r;
>>>>> +
>>>>> +	r.t[0] = b[2 * k + 1]; r.t[1] = b[2 * k];
>>>>> +	return r.u;
>>>>> +}
>>>>> +
>>>>> +static inline u32 pi_swab32(char *b, int k)
>>>>> +{
>>>>> +	union { u32 u; char f[4]; } r;
>>>>> +
>>>>> +	r.f[0] = b[4 * k + 1]; r.f[1] = b[4 * k];
>>>>> +	r.f[2] = b[4 * k + 3]; r.f[3] = b[4 * k + 2];
>>>>> +	return r.u;
>>>>
>>>>    Hey, I was serious about swab{16|32}p()! Please don't use home grown byte
>>>> swapping...
>>>
>>> This crap comes from old paride.h and we can't get rid of it without touching the protocol drivers
>>
>>    I don't argue about the *inline*s themselves, just about the ineffective code inside them.
>>
>>> (comm.c and kbic.c). Maybe use something like:
>>>
>>> #define pi_swab16(char *b, int k) 	swab16p((u16 *)&b[2 * k])
>>
>>> but I'm not sure it's equivalent on a big-endian machine.
>>
>>    These functions are endian-agnostic -- they swap always.
>>    If you only need to swab the bytes on big-endian machines, you should use cpu_to_le*() and/or
>> le*_to_cpu()...
> 
> swab16 swaps always but pi_swab16 does not on big-endian. It's probably a bug but doing the correct thing by accident. Other protocol drivers completely ignore endianness, probably because PARIDE was meant for x86 only.

Fix that. ATA/IDE uses little endian. So all command & replies fields
should be handled with put_unaligned_lexx()/get_unaligned_lexx(), or
cpu_to_lexx() and lexx_to_cpu().

> 
>> [...]
>>
>> MBR, Sergey
>>
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research
