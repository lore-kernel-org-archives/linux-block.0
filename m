Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510553;
	b=rfB8lndqLXEZuP4mzJSktfOj8tM4xPVKUnvZo2aTwyhDSqFgQpEedSrjIWBAHqiUW5EU
	 BmXU5jIa+LVxU3ANfkVoQfeypdaXC/rC9SF9sCGWxHihRDrx18wx2SCGg3+r7J9TW+rlT
	 ClUN1gwGcmxQfhIghGiPtXGxbFLvXe9pbD4ti2iVKdpUKBnXFyugSRC26eZ4tltVO49iC
	 Vcmq9JDrzIW+FzjefqFi7ZRd5RJIDp5/86OGkPfB5oItiomU2LudjhQqcwIJRJp+RpgaB
	 KA2dLGQd6yLB/TwTKqVegmrzLgqL24aay+tqhcm03Rd52HbkMHtUhXEcdtYv5ErgHPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510553;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=7PI24Hp56cbBIOzGihzdyiMCzKymcXcc/gN95e0vkU0=;
	b=XAmF+bEecsGvI1gyjw14iuskomiLe3BNntuBJkhVIxArnFUdgHHplnS817nM7mzrKEeP
	 lPLxhhOVKmIXHyiFdADzdqIkGPBYv98ti1xgdUgEG1r7I3Ep9Obx6mljqqYk64pmBUJko
	 xLzUsyprPOhYT2VEwtUr82duiFcUTo4+8EK5i8JYUv5SsU9Tjy1CsMfztyCpBkkjYmSbX
	 ONHiR+aMlvxBykgE3aslUi9ykIuYNBXOy9O01Xvq2GA0JO9Tt7PRJltvSIMkpai7KKW8Q
	 BtRZmVGZxxjdcbyLlT+/TsoVm3gsnC2o3T1/vkF4+wxLQsUdqGWkqghrxx+m8wzb7tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=WeO8+g7k;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F78606A31E;
	Tue, 24 Nov 2026 08:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58F78606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=WeO8+g7k
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jYc921hBhz6VFl;
	Tue, 24 Nov 2026 09:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1795510550;
	bh=7PI24Hp56cbBIOzGihzdyiMCzKymcXcc/gN95e0vkU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WeO8+g7kYIbpdK/En8ogyNyW7BQQrzBKJfvljsFLHYi4PfmBhA8bj+lDSw/aCNhkG
	 DxJHajwbbiQLEoRdi0qy8X4F1K/GCKO+K1wFW6IE5jTwiBbvaBSLFeE0nwa9YN0qn2
	 vLL1izH5vrEBHSjbOdQI3YNq9XVNevyPYNPC/fdgAnSfOC8Y+uBi0ADrbMcAW3uDk9
	 dZQM/YVJkzWt75hXo36SmeKPvL/peK/WN1WtowuL9N1mlJQlKpLzOJ1kvkq/zGiw0I
	 F+rJvPvG98Jq80tczUTPnbyDxARB+GvvTAiFNrUCjRvkpb+E4LTGVv8MXRX9JxVz/5
	 YuNbKz3UfuTFA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4jYc920rZlz4xRy;
	Tue, 24 Nov 2026 09:55:50 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jYc903rKkz8sZw;
	Tue, 24 Nov 2026 09:55:48 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id CCFB75F9CD;
	Tue, 24 Nov 2026 09:55:42 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
Date: Tue, 24 Nov 2026 09:55:41 +0100
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
To: Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 regressions@lists.linux.dev, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
 <awSs5Cw3hFkf4O4T@ryzen>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <awSs5Cw3hFkf4O4T@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179551054343.1350673.149703183801774800@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: CCFB75F9CD
X-NC-CID: DCewlNIOHCbu9CVBhGpOPu7ikYcAXBgk+sLCzd4bkxfPEMobKqs=

[Reminder, this is not my area of expertise, so this might be sending
everyone in the wrong direction -- so handle it carefully]

On 11/23/26 22:15, Niklas Cassel wrote:
>> Since the issue with mounting the rootfs disappears with intel_iommu=off, I
>> wonder, whether there is a limitation on the maxmium block size either by
>> the hardware or from the configuration of the IOMMU and SATA controller by
>> the kernel.
> Considering how common your SSD is, my guess is that it is somehow an
> IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI tables -
> DMAR on Intel).

I just a few days privately was told that "intel_iommu=on,sp_off" solved
problems wrt to one unresolved regression related to iommu with a
similar generation intel hardware. The user wrote "[kernel] code
improperly thinking that the CPU supports something called "superpages",
which it does, but only when the integrated GPU is disabled (speciality
of Intel Haswell)."

Could that maybe related? Do you use the iGPU? Does that parameter
prevent the problems? It's a long shot, but quickly tested, so I thought
it was worth mentioning.

Ciao, Thorsten
