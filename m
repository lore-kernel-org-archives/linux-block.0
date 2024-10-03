Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC0A19B59F
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970047; cv=none; b=O+VMTDFHZKsp246JUIc0BNkQ21kbwRhixgvdbMam13nx8Bx+vP4jM5HvK8tygCQMHg4Bnu5aWMPia3iblJVXaqXKdgpjDmzD8OPgyMWE+Aoz1bs02jkWhR8upqWkTrmmUHtIe0CYS8gsf/OtX7gBn+hFfj0gsYp/le1p3BTqGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970047; c=relaxed/simple;
	bh=Xv+2+m+4+JYvcQpIPGbXQxe/SOmY4LHXHGq7DU2cTwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K99iRiXT1jNdzZ1Vetxvn6LwtrUbDAbps/UU8XZ7VbXm5ObYo3sIFmZ8gDMUKzb3/R6OhvqAsFHeFnICYZPbQdA0fDf7hNEaX7M9lskEqtWKhCsSTWnuphRmZUPIEii9oJVKp2Z8hxoaIDkKPnURgCZHusicEdvXClnOM8QdfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RIxDhf1N; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RIxDhf1N"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82aab679b7bso48211839f.0
        for <linux-block@vger.kernel.org>; Thu, 03 Oct 2024 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727970044; x=1728574844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3F6p04osyI0jBGzF1g/V+1s/zjy9v4C68ZQz9+vQuaM=;
        b=RIxDhf1NLvcGzQJ5n9h9e4yE8wPg6JhgrE1VmXmwUxZekR2xY2400Coaot7NVf9J59
         22nie7OB7BQHXFy5JhYFhHriw1tThaLz8uoKbYv0D+0Xzim+L7Rx3Kxo1GKqiQQe7e3P
         3laI6DaueM5zzzCUAC+oNcIUjacWNZ2vF6IXHfcXxC8AeXVPwcG4HRhP22GKi+VWdIKi
         i073l/GIzii7b8hMe4mywXk0N/xSUSEa1NHAAfBXadmkorNZSWtvP21SfOkgWPxiR/F2
         sOY8WHUGzy5o+RawssRYYh5G8GKeSKFOW/0gc/aKOy0tw1IWc/JYMT6e80rC5w6sXD8c
         7nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970044; x=1728574844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3F6p04osyI0jBGzF1g/V+1s/zjy9v4C68ZQz9+vQuaM=;
        b=Y6kvd6mPn9xMjEHklXqxWaQUgOF+xyTRrGSnRv+O61flGTZCE6BlFNHDyfcrZY93T+
         BUkSNfaga9RhBT6pjJEQMqel+H8eIshLUvtrx2I5A7QHHGKCLYt2nSlwQrkg7t8N8nGM
         Pbw7DcXmfYrattyVPnAW5fZzX2O+Ko6xvcCOfgwo0D4UCTi3yYMsy00JpV6iOlDA2ZUM
         22JQZETHgId3j5SWB3r0Lx2aMk+YoG4Hoi1NxbCawaKqBbhnxn6A12+LAE0W41Tg82GD
         0CqUuSoMlMX6E94DQvVJjHF/LW+aPZJzCm6GJ8G9kVqRD2kp7nyHX99UM8YZe5WxbamO
         WeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc2/CzuhDk+C1JrGnXr7EmT+K8fbYi8uBAZjKns9FArT6JMI3geCOcUbve7OwDlnrFf8xwm+pnWFZcSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXK5HOMSX+3AAdDS5pQNf3AG+C0AvKYvazDY3Tk87v06JesMD
	NxIwA0u4uuel+Ar3GnnRfwgHnHyk2M/2IJbKDVqQSFErQZ/nlgc+/40HPDf7mGs=
X-Google-Smtp-Source: AGHT+IGVeksN9lMqLrH0bdyiZE6lj04kAENcVkW1NzWCeTQqeC5TiiITBRhfRVIInJjo07jM+atEmA==
X-Received: by 2002:a05:6602:1553:b0:82d:129f:acb6 with SMTP id ca18e2360f4ac-834d84d4e60mr669700239f.14.1727970044432;
        Thu, 03 Oct 2024 08:40:44 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55acf198sm320040173.165.2024.10.03.08.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:40:43 -0700 (PDT)
Message-ID: <d1738d8c-023d-4a37-9b49-f9b42290ccd2@kernel.dk>
Date: Thu, 3 Oct 2024 09:40:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] block: enable passthrough command statistics
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20241003153036.411721-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241003153036.411721-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 9:30 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Applications using the passthrough interfaces for IO want to continue
> seeing the disk stats. These requests had been fenced off from this
> block layer feature. While the block layer doesn't necessarily know what
> a passthrough command does, we do know the data size and direction,
> which is enough to account for the command's stats.
> 
> Since tracking these has the potential to produce unexpected results,
> the passthrough stats are locked behind a new queue flag that needs to
> be enabled with the /sys/block/<dev>/queue/iostats_passthrough
> attribute.

Looks good to me.

-- 
Jens Axboe
