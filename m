Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795504842;
	b=m5iF0jBxLeJqjoh6QH7dESnLaRAHV4knxzhjMtxxRf/SilcX7Ct+fCZm1GavKCgiK/y2
	 7G0NlHR8NtAye/RAYyYS2vAdGH2m+FJHUYOUlKj9sMMRNI4E+/TuW7PtTVEk6ZuIiKcLw
	 ORE7cvzmOPyw2TdCPAGFp86PdTkiNRBxIF+73Vr4plQtXgr7eqF/CU5UWT8m/687vAG+6
	 ng7HeK7kRGutwQvNzxCFWKYRvuRae+2/UWl2r7hoT0AQ9EaB+pC83/30JusIyxQ6xj1xh
	 L5Ufm5rsMBRCuYRfXiuhJvjF4tb0kxwpnuyMM5lpHlE4Vn5wr0OemehoifeUCfCO+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795504842;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=tHvSxvXCf5VkLnPhHQoHOjXTPcUMHCtMx3XeIE3rH08=;
	b=CMmrFcUVPjU9bxY4WHHAOtbXXDdW0p5HYrRvF+eezRVpQv7Fy0o//9M8MqI/uGbdwWrm
	 Ap7exqDdjudKZqGWcTRJmwBzo9PfUNBXMFow99LyrItvcztuxgFcKom0P+IzoVhj5RZjt
	 Dbre2HgS11vmUB+Bse06QbIEWcUqJy3LkakejDnHaZGEcFlDfnsd0rlWgqvuemQaHkFP5
	 iHdU7zNgzOab8xoKxHz2sW9usDB1rxsIG8vEYcOnSQjJ4nL2xdNdY583cEuR+gpH8ja5X
	 9LBXVbGN99Ph9BsJRXFxVhrsxUYNhxpLngazUA3H3n3nYjrb1yNf/iPgK5ge2AP9Wsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=CsoC5hck;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D47606A32A
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 07:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D47606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=CsoC5hck
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E8578240103
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 08:20:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1795504839;
	bh=tHvSxvXCf5VkLnPhHQoHOjXTPcUMHCtMx3XeIE3rH08=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=CsoC5hcktA08PIURAy8uvdKnj1gYgr5vDUKTQma8mgYzRrKQ38bWNDlB8LJ97gi4w
	 rK3727e8WOkEgU7XgZnOg5EMSySyOKmfVb+C061+W1AJ1wOCmg57Pf/VPG0Nu5uKCS
	 fvlhYRQ5MLZBJbHORM3Jd6++PHSsXpnqSBCX6D8BqSn4lhRIfkJtynDJ/B2akwqWFQ
	 P0ojy/ceRnTi8T7tf0dZOtuJJ3dh1xCbAQb7HN6/Iw+TgDU6Ixqwm87X5HSYG+0jnM
	 GhsAsP7OioCl6JweO0wkLN68Xr2dqc4pvyorANu2ykPcgwb4lF9xBJ9uAkxoDu1Wtj
	 iHKlpdzmsrTCQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jYZ3B1gqXz6tsb;
	Tue, 24 Nov 2026 08:20:38 +0100 (CET)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 07:20:39 +0000
From: Tobias Laas <tobias.laas@posteo.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase =?UTF-8?Q?BLK=5FDEF=5FMAX=5FSECTORS=5FCAP=22=20=28=36=2E?=
 =?UTF-8?Q?=31=37-rc=31=29?=
In-Reply-To: <awSs5Cw3hFkf4O4T@ryzen>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen>
Message-ID: <572a3776f303846961d9897c55421a0e@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Am 23.11.2026 22:15 schrieb Niklas Cassel:
> Hello Tobias,
> 
> On Mon, Nov 23, 2026 at 06:51:03PM +0000, Tobias Laas wrote:
>> One way forward could be to a new entry to __ata_dev_max_sec_quirks
>> similarly to the recent commit 
>> a12cc63129380a5364e787d92b30a3257f66c250
>> ("ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8"). 
>> However,
>> I wonder, whether that would fix the underlying issue or rather be a
>> workaround, because 4088 does not fit the pattern of all other 
>> entries,
>> which specify either a power of 2 or a power of 2 minus 1.
> 
> Your attached kernel log shows that you have a
> Samsung SSD 860 PRO 1TB, FW: RVM02B6Q
> 
> This SSD is probably quite common, so I somewhat doubt that it is the
> SSD that is at fault here.
Hello Niklas,

thanks for the the quick reply. Indeed the Samsung SSD 860 PRO series is 
quite common.
> 
>> 
>> Furthermore, the first error messages are DMAR faults, and a SATA SSD 
>> that
>> isn't functioning properly shouldn't cause any DMAR faults, because 
>> the SATA
>> controller should never read from or write to areas outside its memory
>> region.
>> Since the issue with mounting the rootfs disappears with 
>> intel_iommu=off, I
>> wonder, whether there is a limitation on the maxmium block size either 
>> by
>> the hardware or from the configuration of the IOMMU and SATA 
>> controller by
>> the kernel.
> 
> Considering how common your SSD is, my guess is that it is somehow an
> IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI tables 
> -
> DMAR on Intel).
> 
> 
> We have seen similar reports here:
> https://bugzilla.kernel.org/show_bug.cgi?id=220693
> https://bugzilla.kernel.org/show_bug.cgi?id=221713
Thanks for the pointer. The first report sounds as if it discusses 
several issues. I agree with Ivan's comment at 
https://bugzilla.kernel.org/show_bug.cgi?id=220693#c42 .

I am afraid the second report is specific to HP server mainboards. In 
contrast to the logs in the Debian bug report, I have never seen the 
following error:
DMAR: DRHD: handling fault status reg 2
DMAR: [INTR-REMAP] Request device [01:00.0] fault index 0x1c [fault 
reason 0x26] Blocked an interrupt request due to source-id verification 
failure.
On my mainboard, I have only observed DMAR errors with [fault reason 
0x0c] non-zero reserved fields in PTE.
> 
> Does it work if you 
> revert:https://posteo.de/webmail/?_task=mail&_id=4553111306b0538dd90e75&_action=compose#
> d373449d8e97 ("iommu/vt-d: Use the generic iommu page table") ?
To be honest I built many kernel versions between the increase in 
BLK_DEF_MAX_SECTORS_CAP (~ 6.17-rc1) and HEAD for the bisection, and 
since the change you mention was not included until 6.19-rc1, I have 
tested kernels with and without this change, so I doubt a revert would 
help.

Best regards,
Tobias Laas
> 
> It would be nice if we could involve some Intel IOMMU experts.
> 
> If the ACPI DMAR is at fault, perhaps it is possible for the kernel to
> patch the ACPI DMAR for your platform.
> 
> 
> Kind regards,
> Niklas
