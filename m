Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD64D9579;
	Mon, 28 Sep 2026 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616919; cv=none; b=Q0Shm3CZBH8tRs5udiw8whM/Pr3xYRKpKZU64tBM3EbOr4wW12phGJBqsdD0gggEH6D/qoSqhQb2nALjlfnS7+QXKSX/s7r6aZCrlBGiFUveSRTfebC+VamsYbAB4TvyLBdvw9iCBty8r8WKaygGg4x9VP3NyqlkiImZt90PDA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616919; c=relaxed/simple;
	bh=a1Xz8gOMrbnWiCV7MO9KjZqCjlooL7/JX11cGI89XKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ew32cXQ1q6um4MWP/r9Fnq3GHyucpo3T7x2nJnR22l04dw89hBuxHdeniF5E6oNhhzkcJrk2OqqeRP5leIoEAUwQbDrrmromCU/8ufsjqsJQX0PN6EVCxBpbTqbcbRw0x2CKvwchZ1AccMsjRvNzYyo7s4H8sQYz3I+KJvMgzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=27M34T2U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="27M34T2U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=0Muik2gLDIU0zwG0MAg46dCEWoNDshcBOYcdFxQ0h64=; b=27M34T2UhCP2j+CVLAJsecw8xA
	+bJxgFD/u8GlFDl8mhZkUwDkWjPOeaKAlbND7iGdLDDu/+dy4p/CTOsfhCOaR/JyfgYLw1YEOoXzt
	drCi8ZC+AJYbVQ5dLkUZNCV5xOe5UBuXhDyUzP7Ga8eYUq9cjY17mWjkxlcU0PRwLT4jVeJJthizD
	np709GBZCcoqM51ry8Lk3GqMkrXflKtZFqfnz7RhX2AY4oeK9tKKImVEAFM/qH6d3iMYYqkUZTFxG
	VG7SkdQlhj5pFkLaEDdQqbOtxTBvHcbV2y99xHSS5fUFLX2If5uDIcVseTNCHI8HB0ZNhrTv8e103
	LDf4/+Bw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBFFz-00000001BBN-2mwS;
	Mon, 28 Sep 2026 17:35:15 +0000
Message-ID: <453fa7f6-dbbb-4023-b1ad-ccd6d746a138@infradead.org>
Date: Mon, 28 Sep 2026 10:35:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] ublk: refuse to go live over canceled io commands
To: Josef Bacik <josef@toxicpanda.com>, Ming Lei <tom.leiming@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com>
 <20260928-b4-ublk-cancel-stop-v1-9-4a4360232a46@toxicpanda.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260928-b4-ublk-cancel-stop-v1-9-4a4360232a46@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/26 9:00 AM, Josef Bacik wrote:
> diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
> index 28300fee22bf..05d702f66a93 100644
> --- a/Documentation/block/ublk.rst
> +++ b/Documentation/block/ublk.rst
> @@ -118,7 +118,13 @@ managing and controlling ublk devices with help of several control commands:
>    After the server prepares userspace resources (such as creating I/O handler
>    threads & io_uring for handling ublk IO), this command is sent to the
>    driver for allocating & exposing ``/dev/ublkb*``. Parameters set via
> -  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device.
> +  ``UBLK_CMD_SET_PARAMS`` are applied for creating the device. The command
> +  fails with ``-ENODEV`` if any fetched io command got canceled meantime,

                                           IO or I/O
                                              command was canceled

> +  by ``UBLK_CMD_STOP_DEV`` or because its io_uring is gone, and the device
> +  has to be deleted then. With ``UBLK_F_BATCH_IO`` it fails the same way
> +  after a ``UBLK_CMD_STOP_DEV`` sent while no process had ``/dev/ublkc*``
> +  open, or after the current one opened it, even if no io command had

                                                          IO or I/O

> +  been fetched yet.
>  
>  - ``UBLK_CMD_STOP_DEV``
>  
> @@ -195,7 +201,12 @@ managing and controlling ublk devices with help of several control commands:
>    command is accepted after ublk device is quiesced and a new process has
>    opened ``/dev/ublkc*`` and get all ublk queues be ready. When this command
>    returns, ublk device is unquiesced and new I/O requests are passed to the
> -  new process.
> +  new process. It fails with ``-ENODEV`` if any of the new io commands got

                                                              IO or I/O
                                                                 commands was

> +  canceled already, and with ``UBLK_F_BATCH_IO`` also if the cancel of a
> +  ``UBLK_CMD_QUIESCE_DEV`` reached one of its queues after the old process
> +  released ``/dev/ublkc*`` and before that queue got ready. The device has

                                                    was ready.

> +  to be deleted then, or the recovery
> +  started over after the new process has closed ``/dev/ublkc*``.
>  
>  - user recovery feature description
>  

-- 
~Randy

