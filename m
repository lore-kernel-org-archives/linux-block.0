Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6852C9A;
	Wed, 24 Jan 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135560; cv=none; b=WwQ10OLve/f6De+TbjG0XGR3udYuqRTGuk2kctX5fQaju/9PwfjtLDH52MjBhApwoahPOnoTz7oaSFC861JvjCE9/Zqo0PSYwGC6c/bWdxhTunnWEigaAO/4H1TElFzgaYeemPsTZgtMOmJZwQUZeVTsP1ELYBHb1CH7lHkhl+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135560; c=relaxed/simple;
	bh=Cf4TbRtQv66gVbraB6zo3Kn5eL2uP+kvPg2Y6ryomGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNpEK8jGR08xxMuwWXSq5AepTsz/w4H8dk/okJJKgyk6IshRe6MqwD7KZmvOwIIPELeqOqcj4G2X6V7oLN7RF+H/Td+JJqdqqNVlqMAU3jYarP3QBc55WJucJvkqfXZJid/QIQUWnzeba+M/5uBjcH8u72weoucWiQE7USqyzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnqHXwFE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnqHXwFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFC3C433F1;
	Wed, 24 Jan 2024 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706135559;
	bh=Cf4TbRtQv66gVbraB6zo3Kn5eL2uP+kvPg2Y6ryomGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZnqHXwFEiVLW4jWqt58ZaF74SzDxTykXns8nk+eMGq1EnT9FOH1k4OMPx/jhBENKG
	 TmCvdHBww1FGR4ZBEN5zAca0im5ViClRyIPu3dL+O54quHJte5CmXZqNMi50vB8P5g
	 MsImFMW31OqYt73wEei/A+oGnd91NTrIFR5l/dEmL0ppPq8BFDnD3hA5mwbuBuqO5B
	 SOmaHj9UilolP1bDX0/a15N7zRK3zx+J15jeN/EUrcGRKRY0PEwC+yvACRmTkG+sGT
	 xyE3EAIsK38jfTaV4aZtDrS0FkRVkcBPCOxvgAc+RTg0RrGyjXPPIHgOulL0ft9UsU
	 +GXtuj7ll5aHg==
Message-ID: <772618f3-f4d3-470e-bf06-70d8ee66d7b0@kernel.org>
Date: Thu, 25 Jan 2024 07:32:37 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <ZbD7ups50ryrlJ/G@fedora>
 <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 00:41, Keith Busch wrote:
> On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
>> Requests are added to plug list in reverse order, and both virtio-blk
>> and nvme retrieves request from plug list in order, so finally requests
>> are submitted to hardware in reverse order via nvme_queue_rqs() or
>> virtio_queue_rqs, see:
>>
>> 	io_uring       submit_bio  vdb      6302096     4096
>> 	io_uring       submit_bio  vdb     12235072     4096
>> 	io_uring       submit_bio  vdb      7682280     4096
>> 	io_uring       submit_bio  vdb     11912464     4096
>> 	io_uring virtio_queue_rqs  vdb     11912464     4096
>> 	io_uring virtio_queue_rqs  vdb      7682280     4096
>> 	io_uring virtio_queue_rqs  vdb     12235072     4096
>> 	io_uring virtio_queue_rqs  vdb      6302096     4096
>>
>>
>> May this reorder be one problem for virtio-blk and nvme-pci?
> 
> For nvme, it depends. Usually it's probably not a problem, though some
> pci ssd's have optimizations for sequential IO that might not work if
> these get reordered.

ZNS and zoned virtio-blk drives... Cannot use io_uring at the moment. But I do
not thing we reliably can anyway, unless the issuer is CPU/ring aware and always
issue writes to a zone using the same ring.

-- 
Damien Le Moal
Western Digital Research

