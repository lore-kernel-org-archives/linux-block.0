Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3B2D372B
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102127; cv=none; b=eY2/nfMbn3TYlDLGhU/RH4qf8V5kbxEwqDAt7CUiVG8Os/Svx48IDR/+cTLk0uJqXwGnmbQ+SULwFWeeH4zAx9n/3zzN2ecyC1A6cf43PU3u3UsU/EHqzus0mRw8xZZqSG96bMa9smOCf0OFc0X73K13kLMxx8zN+nEqKkAgd1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102127; c=relaxed/simple;
	bh=zwPnXvS6Z20sRe1yclSQA6Xw2PAfcNtWCoYFzUe5Ec0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1jdu4wcrNttYUrpMJWqie5jrL1zjM+LTRe8ue6kG8zwLiCZP4EdspqG6V8Pm8wopT0XQxwL324fQNS3yxhsOPdyWJbqQ9s7iar/dxO12hvR5Mx3hNO9FJPRrRpZD/WaD5Lw5+NDDfX8qA2lW/nf8UZhkQg/+rZlZs1GR4YTsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T52kxwT+; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T52kxwT+"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-87c124eb056so206622539f.2
        for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753102122; x=1753706922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iN9DqES2H5eGVb7Ndape32xY8pxTYhHdwjUy09n73A=;
        b=T52kxwT+WQiL3jqdDDlnWriWXN14d5jfJqXgM9+TznDU0SfRkK1rgwPenWmvq9/Hoc
         njpt3sLT6hemELHZNmL7mwrSfB/3D8q7RE08ycXG76OErsntC01Q2fviDZCPBq+yKjMA
         LG/6/tISLg4vU3rHD+14PjIlYpl35Sf6CNxQBjleIZZZpEjCf7Oz59OYOzKdb2PriQJQ
         VYuML7YCwj71G/54PGXQ3WXtU+PfjF197ySxi7pTJ0pRVTE8uZxEvHALjsSlJwle5VCM
         XZttjqeDW0m5BaBkgatcqjqnYU/ETGUiyfmfTQETjKl8r1uevhH3Of1QtjJ4nMVdJhgu
         zotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102122; x=1753706922;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iN9DqES2H5eGVb7Ndape32xY8pxTYhHdwjUy09n73A=;
        b=Paz3h5aE9Uf3h6mpWuWMPxJ/MX7hbJVDaLsb6H/fYcGzfXdkGeeNEd3ja2HSEppnHR
         7sZeDExHRJYWOK8g9XnZmJ+vGBf4whz+W1HwqVZXnssRoloMyIa1kaYBLMopTvcns2RH
         7Bax6YtLUsCVwzBHET/TUqUBLkoqQa+7rQWwQBhJydaYfzqEEh4OwWdm3iJ3FzsyYHgD
         Qdjatf4uuqVro98XoXgVYGw8HE32o96BeMSnOOE3qcEsTJsP02S8pkYhGQBqc9oIZdmp
         e0uZgI/RTEUKIW476OBMjMY1Iq2yLf8HTH1hD0+GugSgOyF7o+u/HODmAy1y039VBK34
         R6Vg==
X-Gm-Message-State: AOJu0Yy7824ZO1HPTSAKUuSwphJ/9Rbbd+uwUTF2SZEgO/rX+kgvxG72
	4Jifv3Yd/Z95O4gTVviQ3Dz1/hBNZ8cWwwmMQdMa5HyonRktEtLLhs0+ns3zLK6FV9blHTjWqJ9
	CloHb
X-Gm-Gg: ASbGncvnBOU7058/PWEZ9Y7hoM5z/s1JM0QeJydDVEKOVRP1i8CFDId8ajuKuHhC6YD
	gGY3ky4N05NUkqORnxrSOibsfxfRqEdtdCJiJ+ud1NeWOEqzUMADscvLbS1OKDNgL1PiTPn8cJy
	UHuZADYSxwhKDb4MHlzm+fVDRUQfvPOFM1Nxw2wkJ9iI4Kn8VOZtjoHFrZIq0lDXVv0Mo+yU0XS
	evbbG56x8AtudY2UUditzb13fOopWhPI6tcBWGhWwKdey3ykwzTStzWbr3YzfKkoZiMCzTD0zX5
	5GWAGWuJx9FLZ85qihctB/7rWOkfGwebA8GDppqfj7tKR/O/m5HoNbufCxWj4Rihra/w1p3gNwJ
	qYki9nePjsy9PDg==
X-Google-Smtp-Source: AGHT+IGGhlEt/oqcJKJOWjTKzPrEAYuGc0JFbRvWMXVIQ5mcBdl5z16hgcwJMQCdWaKbhpR/GTuw4A==
X-Received: by 2002:a05:6602:485:b0:879:c608:d1d5 with SMTP id ca18e2360f4ac-879c608d725mr2588566739f.14.1753102122019;
        Mon, 21 Jul 2025 05:48:42 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c0e74d059sm205787639f.39.2025.07.21.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:48:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, gjoyce@ibm.com
In-Reply-To: <20250719132722.769536-1-nilay@linux.ibm.com>
References: <20250719132722.769536-1-nilay@linux.ibm.com>
Subject: Re: [PATCH] block: fix module reference leak in mq-deadline I/O
 scheduler
Message-Id: <175310212098.555365.1305613262179721091.b4-ty@kernel.dk>
Date: Mon, 21 Jul 2025 06:48:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 19 Jul 2025 18:56:47 +0530, Nilay Shroff wrote:
> During probe, when the block layer registers a request queue, it
> defaults to the mq-deadline I/O scheduler if the device is single-queue
> and the mq-deadline module is available. To determine availability, the
> elevator_set_default() invokes elevator_find_get(), which increments the
> module's reference count. However, this reference is never released,
> resulting in a module reference leak that prevents the mq-deadline module
> from being unloaded.
> 
> [...]

Applied, thanks!

[1/1] block: fix module reference leak in mq-deadline I/O scheduler
      commit: 1966554b2e82b89d4f6490f430ce76a379e23f1f

Best regards,
-- 
Jens Axboe



