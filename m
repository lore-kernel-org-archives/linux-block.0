Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0062C11FE
	for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266492; cv=none; b=og8Rqyqnf91e+yBWKlLBbtnT2m4g33oCmuzM1f9mYoW0G0q2/q0Z0yJrf/QLeHQ3m69ffWqFMABSyeiAQKkmpHIQv7PTbJmBUPGMruiYETFRamIW221rbMFRxIq6/74XoGsUnzPnyajNw0eGD2SB+LS0WF33JHH0cVqelWFYkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266492; c=relaxed/simple;
	bh=DXdW2sVJpUEGRsnsDNt3IDY65YC/KG+dJKnnrkCN2No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot5MmV4CXvRCJzO+j6ABpUkAw1hkrkxSZhVf+ZPMUV9LXGmtbFiCLwohEtFILEE//Phb9YYn/5aFSYAB4Zvc+VF5eH1xtsLLD+G3P7kL8QpQQdCSsCIyGdlni75mMNoADXxuXchdvs5zgQyV1w8aaKdBDXvt/gc9emtTw6VlLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vzot2n/f; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vzot2n/f"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaecf9c325so24418125ad.1
        for <linux-block@vger.kernel.org>; Mon, 16 Feb 2026 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771266490; x=1771871290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1Yj1yhuptOSylTDyOUs8iyxlJcujGeDn2NjJk0xsTM=;
        b=Vzot2n/f3TKjMdB3hfeRySQcM9ZlEKJ5PMVQqz4/D6yE+pt4EFNWrV7PN9g1WsGFSz
         Yha/xxkHF8k1LxjgLJJLiIgOVCrkKqrIygapjAO39Jgso9o3Zt7eCxm6ZRS37dEPHLQm
         wwpajlsr8iLr4arXLXbT+/mR2oL4d0X2w3FwB7Nht5zPVEO6dunOSGZsFgZU+MJ61vVa
         7izyhQVb3iOqXV3oiwa/7OOItjuG1z+c0VueZFdBDN6YedTJi5NvCrQrS0Tx+8tHslrZ
         H7BPCR+0n6Fr+UCdYBrG09+CbaqdpmCLQbbXngZ+/IGT/32/xkfkP/jSo5+8Z23FdvRS
         GLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771266490; x=1771871290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1Yj1yhuptOSylTDyOUs8iyxlJcujGeDn2NjJk0xsTM=;
        b=aAigtzkZ4e9mImNCitX+7+gsAVKFS6B8EHtpm8eEk2hSfK/FgDuqCpalrJ0mIqoqY+
         YriVf+3K26taZ6uDIolmBRYT2LL9cur7aHR+QQAcAHnzl+yFxkipb88CyvOcIbbE8Wu2
         hEP0ejg6FlVApBv2nJeL+01ILUZs9JO1W5Jy/bAqzWjX2TJ9mPRmmKawNhlYCpGCLEH6
         wWV8eVofHbt7eU0oxyXRUb0OtJZkfFGf0lhong8u1MWV7YtWE/OnSxUJpHnCaO/yGfhr
         tVu9BZAq9u7oXku9XjDyXVC6q7eMdsEr6jCP4mn9gRwuPVGv8wKkYzbM3G6NCWMUnmDJ
         dh1A==
X-Forwarded-Encrypted: i=1; AJvYcCWB9FkpxQer4SOPNnhcCuyEzJjnmlhjE1V7v7zz2WtW1aj0zNaoZGmBmgtElmwKccRza5psP/IlkzBDmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Uc0TV3xA4BokPYjwv4lhrdlKPN/ViBGyxg8b34/Fb9STq0YX
	0FJfDQMvR+LanqJzqxA6WG7LtUbg79SA7zZyWrCwgmX4ktNK9uhWFFxJ3QK3FDlMNu4=
X-Gm-Gg: AZuq6aIdwQlRsTISTkD3eAjWLwumnJzIiZVWHwDn/uj1in/URj/tPoxvvrqA7KeOkkl
	CxO6iVtB8XCgmGgzO9qm1H7NnXwEf+eLCjsPlR1gaNrIf6gXBz5ZVdYkTzHvAnk0Oo7QXlkzjKg
	pvycHzwUVdsh7IXr9hKWRHetY0bfM3l3G7++9GmpqXKG5qaYYVvva3zs42CWqyK2lgoEMAP7xsk
	7j6QEwKUF2Yk730aQDbe26BRCLvRBwj4iBb0sAaxOxZI3RE3tU//UFYm13ubV6l0EJiywV1UTqN
	EY5UuI4vGJWHbo0voUHYmUrIAzdA0tB+krb8uMvfjHZRukOADdoKh/C/sBWUm2HlQlY+0DHYV8E
	j4s7roynsQiBhI0UzwoIi78Pn/05sc5eK/H3mP17KgkDF5BTQxQoqg4pJOyZfCi3CcqNjhx4MZT
	u5mCY1MWzAlaEPaV4Usga94G4WCaCwLpxSXkMwkg==
X-Received: by 2002:a17:902:d50a:b0:2a9:ebae:f3f6 with SMTP id d9443c01a7336-2ac97593413mr94716045ad.20.1771266490130;
        Mon, 16 Feb 2026 10:28:10 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::68dd])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2ad1a9d5df0sm74851785ad.58.2026.02.16.10.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:28:09 -0800 (PST)
Date: Mon, 16 Feb 2026 10:28:08 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Yu Kuai <yukuai@fnnas.com>
Cc: axboe@kernel.dk, nilay@linux.ibm.com, ming.lei@redhat.com, hch@lst.de,
	yi.zhang@redhat.com, shinichiro.kawasaki@wdc.com, kbusch@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] blk-mq: use NOIO context to prevent deadlock during
 debugfs creation
Message-ID: <20260216182808.GA1799879-mkhalfella@purestorage.com>
References: <20260214054350.2322436-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214054350.2322436-1-yukuai@fnnas.com>

On Sat 2026-02-14 13:43:50 +0800, Yu Kuai wrote:
> Creating debugfs entries can trigger fs reclaim, which can enter back
> into the block layer request_queue. This can cause deadlock if the
> queue is frozen.
> 
> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
> to detect this condition, but it was racy since the queue can be frozen
> from another context at any time.
> 
> Introduce blk_debugfs_lock()/blk_debugfs_unlock() helpers that combine
> the debugfs_mutex with memalloc_noio_save()/restore() to prevent fs
> reclaim from triggering block I/O. Also add blk_debugfs_lock_nomemsave()
> and blk_debugfs_unlock_nomemrestore() variants for callers that don't
> need NOIO protection (e.g., debugfs removal or read-only operations).
> 
> Replace all raw debugfs_mutex lock/unlock pairs with these helpers,
> using the _nomemsave/_nomemrestore variants where appropriate.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com/
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Maybe added Fixes: 65d466b62984 ("blk-mq-debugfs: warn about possible deadlock")?

Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
