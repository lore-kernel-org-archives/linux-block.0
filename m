Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596802;
	b=q9h9Ilzfi+VAP7IezQaQt+maLSoVaRC6z/JPp9MGIb54a3sjc6PgP/L6Y/54pyzdrO5+
	 8zOvJ/xqunv2S7SWKiK0QwKWK59COnUqO3qyNLo02dZv1HoWsW8z8iFcuC2Vat50S+9Nk
	 4MHKxFM8VLTYySDHRuPs0nIEniFQZgnpXTQk1efJAhQn1EIaDDRtZ4xYXJSkMJQVuqKUm
	 kwuZcvHo9uxDnWj32dzl1IFH8D6L6KC7R2XrKuITlRZuqoZwd9At+fWxxGgK1VNvArFGt
	 qAjMe9y+X8hmjcj69E/EG0bKovTbPWdxduX0q8Ff5BCtmF0I+AhckMzCKOe2Fc7m+hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596802;
	h=DMARC-Filter:Received:DKIM-Signature:Received:X-Virus-Scanned:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:
	 Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-NC-CID;
	bh=yQ5oP8B/ewMdIJyV3jySqk1F2J/QMkaLPJwixo6jHK8=;
	b=qsj/PSSIoRjXf0m2cC0bOVQ5GTHP88rsWtZ4txO7DEHa0wS7TsZBqyQVs73a1en1Yx1U
	 Ng80rmkZXyYPXNpjYb9BYB9GR/BBEwhKIep4Eqey0aAb/YMrEngUuLRpV9bEtjt9rfTjO
	 joDzfXlryJuzIeJUNxZcUX4aCumCq5Q9l4+HONrE+1EW/aYSbKZUCQ6D3BpaUL6WFel8M
	 kzqHYo4t/y/OHZbBwsnjZovsJqOVdYTBATHCsoJ0Pqo6McHVQRIsc3w9cJdwUshPEySdH
	 AMBcutDnsbFYbGjKLRiJ7T+rqCrcokCeEYwbaNybDVwo5+S+7tw4fu7bpZZa2MXc6kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b="U/u/HCof";
	arc=none smtp.remote-ip=188.68.63.170
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF20606A31E;
	Wed, 25 Nov 2026 08:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF20606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=U/u/HCof
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4jZD3Y0mRLz8rjd;
	Wed, 25 Nov 2026 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1795596793;
	bh=AlE/5na4fH2NUXIJkY/rENlw2S0DFjAKYsvCxIq5tLA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=U/u/HCoff96pu2i1H5b/2oiNQRFeojCP8QwRojd8XWeiwzVAbKeydBXSac5mMIGM2
	 vwEmwPAzOX+P1gXwRyMPYCmrt4q2ayMt7nF9YXhbmwMxvI00qYA5vn7o1fIvU3A9Hu
	 yYV5DNBaz8znvMCOIKW5gPOCkjpUUU9kunqEBRJKrVmRWYdS91+XK9hY4TqkMGIScn
	 Z3RDf7z87DwZhK7Zj31WGGpPTU+s6tkg4R+1LY8pqabMFtjQ3WDMfK/sg4KLOK+82P
	 Z92ieAlUBWdH75gkx+H8FTiQ5c7GcNs1/+cMrCu0R7xvyAET5jKbpkhZbFRv8x47mI
	 Ye3NcJPwU0Lvg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4jZD3Y01pPz8rfS;
	Wed, 25 Nov 2026 08:53:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4jZD3V2kGBz8vKH;
	Wed, 25 Nov 2026 09:53:10 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BEE4E5FA03;
	Wed, 25 Nov 2026 09:52:53 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
Date: Wed, 25 Nov 2026 09:52:49 +0100
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 70sp <70sp@protonmail.com>, Laurence Oberman <loberman@redhat.com>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen> <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <179559677445.1390226.15266907353962811620@mxe9fb.netcup.net>
X-NC-CID: unDnwYxQmKKySfnwJIdL5+kRq/d1VVk2Z7PmvJii7yq21dAmEHM=

On 11/24/26 09:55, Thorsten Leemhuis wrote:
> [Reminder, this is not my area of expertise, so this might be sending
> everyone in the wrong direction -- so handle it carefully]
> 
> On 11/23/26 22:15, Niklas Cassel wrote:
>>> Since the issue with mounting the rootfs disappears with intel_iommu=off, I
>>> wonder, whether there is a limitation on the maxmium block size either by
>>> the hardware or from the configuration of the IOMMU and SATA controller by
>>> the kernel.
>> Considering how common your SSD is, my guess is that it is somehow an
>> IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI tables -
>> DMAR on Intel).
> 
> I just a few days privately was told that "intel_iommu=on,sp_off" solved
> problems wrt to one unresolved regression related to iommu with a
> similar generation intel hardware. [...]

For completeness, Šimon Pospíchal (now CCed) shared findings and a WIP
fix (both with the help of a LLM) meanwhile here:

https://lore.kernel.org/all/QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU%3D@protonmail.com/

Ciao, Thorsten
