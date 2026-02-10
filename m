Received: from lf-1-13.ptr.blmpb.com (lf-1-13.ptr.blmpb.com [103.149.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3962D6E55
	for <linux-block@vger.kernel.org>; Tue, 10 Feb 2026 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770706082; cv=none; b=o+g+AAE5l9ilVC9gDE0EbvFivh2wjvTnJpoVndEhl+p3C+Kp9FQ5a+2zbn04lYArB6A1oUS/GJVMoscgdEASpBvw1bqyR+l1E9t0RPbhZP/Pw9KM6MOOPZdbKpIUKz6/N39GyNi8usjvCsH21pvAw3x7fHfv/2MtdXP2uoT23Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770706082; c=relaxed/simple;
	bh=Q3rsAHTSrLO/NPDxnNxpBD4uJ+ygSuIcGfSsO6jP5KI=;
	h=Cc:From:Date:Message-Id:References:Subject:Mime-Version:
	 In-Reply-To:Content-Type:To; b=UjG/fhll4s8QJZT08V5peIC+U0/77ReUo0/Ntyi6KK+yWQ0lUbZ/6xCV7Mw5zZ3kCXsLQY2rJKhMIR7iR/ZIMJcSM3J0R6KDvfdQfsYxxSnHhYVSp0J3W1JSlob8Wr1h/94jCffHVvDpNu4eqKb3OZDmC4PAjrPRcs0lZZYk7L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=THTV2M7j; arc=none smtp.client-ip=103.149.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="THTV2M7j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770706025;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=B8lLyQsuCZGvaPXxcEDtf7RNvxTLmSi8xokdUUVNsXM=;
 b=THTV2M7jKe4aQpu+v+JWKmpgqac2BexFS/TquKhUs0M8JcLDUxtUemuSWDJCmE8GSVYjqp
 tKEJYJNOmvB4ZQvCWwLT98fY7qEUPRny7z/+ljvGknIzrDrsrVYqSGwX/2K4oTgclbgR0L
 nwnNum/zcJyJHE486QPhLFKZ9ix/H4Xw9dfDD7U0u217R+Gp1GO3A50LLdwUI/LfIvSGD9
 hv4IJ6pJimN/s59KwTLNBXgWNxQo9EFYmrI5SBn1b1xYtdnwMQ4jElh4Wy1wNdcl/ZydCx
 5ZIYNwwyNOygzjjeVxGBjx3obBMcs4is35i1/tV6ZdX41wDbNzhMHqjeXG+K/g==
Cc: <axboe@kernel.dk>, <sagi@grimberg.me>, <sven@kernel.org>, <j@jannau.net>, 
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<tj@kernel.org>, <nilay@linux.ibm.com>, <ming.lei@redhat.com>, 
	<neal@gompa.dev>, <asahi@lists.linux.dev>, 
	<linux-arm-kernel@lists.infradead.org>, <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Tue, 10 Feb 2026 14:47:00 +0800
Message-Id: <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
Content-Transfer-Encoding: quoted-printable
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-4-yukuai@fnnas.com> <20260209145832.GC18315@lst.de> <aYn-xwFHCpd7sITJ@kbusch-mbp>
X-Lms-Return-Path: <lba+2698ad467+c4d69c+vger.kernel.org+yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after nvme_unfreeze
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <aYn-xwFHCpd7sITJ@kbusch-mbp>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
To: "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Tue, 10 Feb 2026 14:47:02 +0800

Hi,

=E5=9C=A8 2026/2/9 23:35, Keith Busch =E5=86=99=E9=81=93:
> On Mon, Feb 09, 2026 at 03:58:32PM +0100, Christoph Hellwig wrote:
>> On Mon, Feb 09, 2026 at 04:29:52PM +0800, Yu Kuai wrote:
>>> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
>>> When the queue is already frozen before this call (from nvme_start_free=
ze
>>> in apple_nvme_disable), the freeze depth becomes 2. The internal unfree=
ze
>>> only decrements it to 1, leaving the queue still frozen when
>>> debugfs_create_files() is called.
>>>
>>> This triggers WARN_ON_ONCE(q->mq_freeze_depth !=3D 0) in
>>> debugfs_create_files() and risks deadlock.
>>>
>>> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
>>> so the queue is unfrozen before the call, allowing the internal
>>> freeze/unfreeze to work correctly.
>>>
>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>> ---
>>>   drivers/nvme/host/apple.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>> index 15b3d07f8ccd..1835753ad91a 100644
>>> --- a/drivers/nvme/host/apple.c
>>> +++ b/drivers/nvme/host/apple.c
>>> @@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_str=
uct *work)
>>>  =20
>>>   	nvme_unquiesce_io_queues(&anv->ctrl);
>>>   	nvme_wait_freeze(&anv->ctrl);
>>> -	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>>>   	nvme_unfreeze(&anv->ctrl);
>>> +	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>> Looks good on it's own, but it would also good to align the
>> apple driver with the PCI one here more.
> I'm pretty sure this series would deadlock nvme-pci, as that driver
> still leaves the queue frozen when calling blk_mq_update_nr_hw_queues.

Yeah, thanks for the letting me know. It's true I didn't realize nvme-pci
still leaves the queue frozen.

>
> We've left it frozen on purpose, though. The idea was to prevent new IO
> from entering a hw context that's no longer backed by a hardware
> resourse. Unfreezing prior opens that window up again. Maybe it's not a
> big deal; I don't often encounter scenarios where the queue count
> changes after a reset.

Do you think if there are new IO coming between nvme_unfreeze() and
blk_mq_update_nr_hw_queues(), will be any race problems? If so, will it
be helpful to move nvme_unquiesce_io_queues() after
blk_mq_update_nr_hw_queues() so that new IO won't be issued to driver
during the race window.

I'm not quite familiar with nvme drivers, details will be quite helpful. :)

--=20
Thansk,
Kuai
