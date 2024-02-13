Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C625DF18
	for <linux-block@vger.kernel.org>; Tue, 13 Feb 2024 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839761; cv=none; b=Oh4/xNbIYL1JdJ9ez8aOv+q0I66vknTicDm7ccAdaA54Mb4+5FYyZBCrWrmFNHzEkW1ANXnSfh3hfG1e5iDZHRA/hf65bJ0Ptmmhg6SrIoKZsrWmLOXXIYdnHFtGXqqGr+bSnH5CmMrBicszpl52/MQhaFmczw9JmS6RtquVTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839761; c=relaxed/simple;
	bh=hWMAioBnPaY3o/tfzz5sN+jFgjLyXD1M9Gr59P8svxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kz9NxgHF8UP5ejLjXvVJfEql4Eo5bjjHuIQ38FlemuXAWiKt8lEdubZNmjWcOmhWa3/ljRktOfZyu/xSDyOl3933p+yBohgoeVNyiH5NuL9U3Q++c6llCDeeJU14N3q2HksjL7s8hHpNBwaQcIDLI1jD+clwKJEDN0LYNVqCAFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t/lQtua2; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t/lQtua2"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-363e7d542f4so3905435ab.0
        for <linux-block@vger.kernel.org>; Tue, 13 Feb 2024 07:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707839758; x=1708444558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDE12yUESOyzwOOqs6qP5OzjvYX0WWrL2dOPvbiyCJg=;
        b=t/lQtua2NxoMawJOceOuybgPH7gUYRGIxIdgdLrigdokK9uyLiaUJk1CfAcekNbhpi
         E6ZNjPyGYj6j6kZuVYh53Lx4YNhB15i6cy5U35tbBXPYliWcRcMaGfjQyV2PrHQsK9uQ
         yg6L3B2iMFc1eCrbo5YnZugpXI088njx2fM/s++TI7ylIGLcsRoGW9XfDF9ck/n4JLRE
         DXRFCgx3eLLQtbn2sAiQ6YhJ3Z6/MaTyn6Uq8IqkVzQLaxkY4cOHg24jmRoqllvl+WZW
         3Bi9HYqTZP1ANp2PqzCa3CO+MjG9C57GLdjwXBAIsl+EPuOYZrZf62oLFVcsTPir9Uui
         vI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839758; x=1708444558;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDE12yUESOyzwOOqs6qP5OzjvYX0WWrL2dOPvbiyCJg=;
        b=T7Vs8W6nfiI9RuyHlboS4MiIdq9tjZ7jhF0UHSup9TtiecV/awv8DAbmtrn/qa8D/v
         Jh0KTgsAi+v2wYgjAz5vKxfEWNvdd41yHjZ/JpLN/Wtto344WWDSjEDUXVmH6tVF39p9
         jw0YjS1y6tm8YcvEbN3Ps/xqliEPmvG/h2OJn+U+LfoCVfE6+wRCgPOr8Huxayq/0TpV
         P5isqViAKz56TeOvi1aONK6I6oNdF7Iv9mOkgGBUaUssD9Tg8Qs7eydmXX8DrZt/P5I2
         GTWIlErOyyipDAoRPfnrOabI4p9Z71C9qldg52n1JhxDyr9qenqydB3hujjEz2pQvoxS
         L6fg==
X-Forwarded-Encrypted: i=1; AJvYcCU3r+xgeP5BP/Y/QM3raKL9d3f7lqcnl3eNCFgpHQkGHzgRJ+BmqUc36nxYGAoOpC0vU193jIE8pFA2n6kimRWBG8vL6CWntqoDo+o=
X-Gm-Message-State: AOJu0YzU7IRv+AUQDAubNbkim5xRURM7PCyRR75Au15XKmT9pru6wvv2
	uzurftOx3e3Fd7hix+JOmR86mT0S90q8BZEnZlSvj8gbTqPWpIdR5i9vniPNi4Q=
X-Google-Smtp-Source: AGHT+IEODykzgn8ir9YrP0mljLSv9E/0vpdgq46Aapczeh99yEQl4PF2hUUpFW8gJ95jH6d6/2UxpA==
X-Received: by 2002:a5e:8909:0:b0:7c4:527d:628e with SMTP id k9-20020a5e8909000000b007c4527d628emr117369ioj.0.1707839758138;
        Tue, 13 Feb 2024 07:55:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtmRN9hf1sTEqQHaomPdDhjZ/rBqevRFQLhRGOvNdVgrrmzMRU46ycGbZdKsVahi7rr3CCulnDlGn0BJCFpzzPWfrqmKcmyOIkohgol58ihRNuG8+McYohme6FmujP543wMnm/GLGvwbCXwyCapal26uTc7epXwG1faZx0XcQZd8e1dfRE/5n0JvjBOAy5vAKs3jiB4mqcZe+FKEoKeP+rQrS2t9y+WodxgE6li2LrIf4tTpUkIO0EBLoieRoDdzN7/nMoZ7PsROrLA2TeuGaUolKkrKX5cHVgWbwC5nQskTG9O8ZBhiJ9zt+foE+YBG4uoGJJNsHK7MMtHfEy9UHEsspFcndMI4XuRq5U3zEugg1HnnhUmUy3Pu1Ld9PGKQsASQk5EkRLEj777Jy5SuicR4XeRRwYKEMWtSBKVQMvCCV03TLdwihjU9FCCc3+HSKHcNUrxFrum66C7KOcpyf4
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ay31-20020a056638411f00b00473ca57bfefsm403153jab.124.2024.02.13.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:55:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20240213095918.455478-1-arnd@kernel.org>
References: <20240213095918.455478-1-arnd@kernel.org>
Subject: Re: [PATCH] floppy: fix function pointer cast warnings
Message-Id: <170783975707.2331975.5627126509877821543.b4-ty@kernel.dk>
Date: Tue, 13 Feb 2024 08:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 13 Feb 2024 10:59:07 +0100, Arnd Bergmann wrote:
> clang-16 complains about a control flow integrity (kcfi) violation
> casting between incompatible pointers:
> 
> drivers/block/floppy.c:2001:11: error: cast from 'void (*)(void)' to 'done_f' (aka 'void (*)(int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  2001 |         .done           = (done_f)empty
>       |                           ^~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] floppy: fix function pointer cast warnings
      commit: 7789bf05529889a39bcf4cd17a68521de063b88b

Best regards,
-- 
Jens Axboe



