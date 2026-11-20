Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178448;
	b=H3roLsEC0f+P0G4/K3NyrR8Eyry7aYd8qm8yeVBr8CJRJk4PHreZSg3yFDE7NixA/QrU
	 SgnFTv1JjTTjJc+LG4p1L35kNnJ57YCNuUF3T7/XX0BSM8M2alJzBhZY7qRFhCmAsHTgN
	 72ab1P3vis/CVVh7Xe1Xwi7ZCYXZrO6rAs2nJ0J1zYo5b/RFaalkWp/Xj18ak+lrNm3KO
	 MaEpzXMbrzXYVvYaKJQcAE9uZINKUOGEpOTufS96CWuNXQkOGlSb1TCD+DOecvhzYYo9h
	 3g6DkQ1VDKV2YA9wqUvft8UUgW7y7Hnx4J4SmYVARBLwSIFL3KGQsIwnJK/dxfF6Azg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178448;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1CwJfyBCLxLwL0PnTLvwM2o7XRXX/a3CQUs39Q4YTPY=;
	b=s3vKGk449ssqOEhjWWZWF0FdhBB1WoIYLZpGDC/pfRHJKyioCAYiFwF5r2uT3QgYf+Yd
	 wNlNn4F1hnAsyageFtz7fRawdkap3guGyohAWl87Z8vvJ1uToKpkyAVZMdRye6miJMG0X
	 HFboQ1xnzSR6tgl64wOjdO7f1qZcenyjLiu0Bp50+2OO9q39b5iKyIAISjUxwHXTIpqEP
	 Its3tkOY8pMmZiX23MzO5FxFMutCQ4co8d/pAJCm9MLjTk/O9As+ldrD+jAbi8P8cAj7p
	 1LpI5RD3z/JZlzzvgRA1RgjOqYE0ph5Tczz8T7X5nR9iBgWhd0u+MzYEucNuNmakbBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V/7IqG9G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF633606A32A;
	Fri, 20 Nov 2026 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V/7IqG9G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4F01F000CA;
	Fri, 20 Nov 2026 12:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795178447;
	bh=1CwJfyBCLxLwL0PnTLvwM2o7XRXX/a3CQUs39Q4YTPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V/7IqG9G1aidQOASPSvwPkH4jR5IteEbffKLBoJx7IYUuoYfE6R+NRwB0TMrsY2He
	 ly0RjzZpz3tFAnSo/S6kG/lMLdVxgc7kO5njSGvZqpjYJDMuRw5WDEFghTsdNDMSCK
	 A+9es7dmLcqJK7QGyGGMzuyIf75k6AKYJRTfZcvFa655K1nubrvLN3VkjkrOaeLabD
	 gdPG16XXJ7r8vbHsefZ258tJTKEhhM8Jkja8e1JiyzZPcW37XNDej/IvRShk42OCTc
	 ci4M8GWW9DGW6TNSJForFI6V+cW8ibPN6TAG0+xvwbJi2RfvbZGpcnw0mv8KYpPkkB
	 60pMEO+uDHqZw==
Date: Fri, 20 Nov 2026 13:40:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ethan <yangyizhen3198@phytium.com.cn>, Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] block: long udev open waits during cache teardown
Message-ID: <20261120-hassliebe-arena-kaufvertrag-3ac58fd0483a@brauner>
References: <20261117105107.14236-1-yangyizhen3198@phytium.com.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117105107.14236-1-yangyizhen3198@phytium.com.cn>

On Tue, Nov 17, 2026 at 06:51:06PM +0800, Ethan wrote:
> The main questions are whether __fput is an acceptable hook, whether
> this should instead remain an explicit userspace action, and whether
> a different block close locking design would better address the issue.

No, __fput() is very wrong for this. It runs for the final fput of
every block device file. So every close of any block device fd would
fsync the whole device and throw away its page cache, including the
cache of everyone else who has it open. udev opens and closes block
devices all the time. That makes the common case a lot worse.

Mainline already syncs before taking open_mutex when it looks like the
last opener is going away. Exactly to avoid multi-minute syncs under the
mutex, look at bdev_release().

What's left under open_mutex is the kill_bdev() in
blkdev_flush_mapping() and going by your numbers that's the truncate
you're waiting on. If that still reproduces on mainline it's a question
about the bdev release locking. It absolutely isn't something to hook
into the generic file release path.

And mkfs can just fsync() and POSIX_FADV_DONTNEED the device itself
before it closes it.
