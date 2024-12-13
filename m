Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AB1372;
	Fri, 13 Dec 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074372; cv=none; b=QkOPZiTq5fblK3oeyY8DJYEFwG6nch/YfIKwv+rcwI9XwMekNL/cOjcs7jLMNB65CIEpk8AueKvsbEr2UVfgDvNa6OglysuM0G/KFA9ETBwx1QsZWaOsQMyOFBarmuLsmd+lck9oN+m3kMqz2usF5SQRaAesYrPQtBquHlRfoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074372; c=relaxed/simple;
	bh=iM/gWRUHht5P+/M5OwNLu+wPaGgz1ftasdaHU95Pv4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EjAbHRTyOeGVRk8GQUb0d3C9rjHbLZPMHZDEx3jaIYEyqhD8UBut/UsRv9E8w0d5rLyd1eD1nqda+1cCaw0NBvFDZykp8PRY9mtvtPXIuHwrFJ0XCXwZWm2UZ2464vEmd0utRt7gZK/eJ30i4xpE8keqHQ9N1SvUwoMHYOPyTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpJfhbGf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpJfhbGf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216401de828so12974965ad.3;
        Thu, 12 Dec 2024 23:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734074370; x=1734679170; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvOoodUP+a37JeWh3OKG8OYxz70uWZTWLs1oVtQBXls=;
        b=KpJfhbGf8V6JSwsLuH+r1L5EPKsYRWBtXAx5Ul8vuXV2YXiBS9EsuSlUp1e8PjhItQ
         1iHsRI4B1wSSSh8JOcJP4nhGZMFn//UwI1x6mnA1lLKwyH6YHWdNOUKLRy1kh03i/WHJ
         ImEB/mVy11PtRgsAhNd+TVmQs/Q+bxKdqjIoPNKsECPWHVoiQkBfQZ4Dq5AkhFNS+H9A
         NfkWqttK7ue+mKwRA7p2CnOM7CKUgj/TrZB8r/5zeybcScxcN/XzJ0ZcLwpDGzVKvofj
         xHnEc1LKAVFcMLEoJp3ixGSXVEchoylU71GxCZWiU9Zyx1HXTxsqhrEzMvqz7Wukil0H
         guwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734074370; x=1734679170;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvOoodUP+a37JeWh3OKG8OYxz70uWZTWLs1oVtQBXls=;
        b=qBn10K3ZbVgDg8Ljd1kBHQBYOpQcwcWMPcnArtjwMeE561SxnE6pKt7it4Ylqag+9w
         XlppwwINFhPac/POYEI6IXYJMtJv+FXlzGXV0atzaLgbE4fvOqRmBA/dUp6yHemfsYAI
         btu+ZqLDG+XgKDx+b/7DgU9wMns5al5nKmnpU0Pw+PTp2xdu2ljc9sZtVbWxIdyIPpBd
         xkJ3mKTHfRQLVZNtHj8Sy1H2Zz+8+wvlWwsvQ+Tm1Kr9Ub+QF/ku+d25H3M6LrFWZDRO
         6oOTls3qNQ7qkJG0XoqW9f+tju1cd5kTKUqUq8xELPki/mEUS8pVxhp10nzisW+KBcvd
         yNBw==
X-Forwarded-Encrypted: i=1; AJvYcCUUoT7bxe3rZqftjfqG0aSs3jI+zRZ9XQn4gt+j+HyRiyJHuWVusb3dEddmMizNKooS9Z/z9uEHPcjFAA==@vger.kernel.org, AJvYcCWWsEb1k1AJqmxCV9y59HX1udTv88GSYE4KxSmJH4JFRtOGLI3XKDDDMeWAn72uDB8Ll+wUxVyb6w8IIs7A@vger.kernel.org
X-Gm-Message-State: AOJu0YynGsZO1HtuktAHFDCiAP+xhNUHj5WKNfAc718WaMhlSzqKlyuc
	P9jE9bU+nqCvsZbytrPJ4A+/wdep+4TkAcUdBw+kthVS+XUFatd4OOqS2g==
X-Gm-Gg: ASbGncsKnSzT9bOegX7me6LxzvndLCLeRw8K5Svpn1G5+3zDdlVmo+qoUSvNxVyyT5b
	81CyVErEezYEqTeiCI3x29GnsUzmMU8fV6AREnSxyiJlxf5qPOjbEjPyeepcDOcAYCnuq2xeVez
	5BoQ+YtFMETu6HMCAK4LkzXtq2NwldbiMvxlm+u5ky2DWNrLALuGGSV3C2jZaRkyMcSsZPx+s0N
	dLyINvL3Xsp9amF7jPc0/ZmIERol6PnedMk7dWDuXLhlzvgZVy2OjopusEJ9Q==
X-Google-Smtp-Source: AGHT+IG0/z6kwnFGdTdmAJeRWa5IroFTx7HXnD7s1VT1EeLiO1uEY7sPOy/JAzK3XIuS08yLg4EUjA==
X-Received: by 2002:a17:902:da86:b0:215:4a31:47d8 with SMTP id d9443c01a7336-2189298b83dmr20807325ad.9.1734074369982;
        Thu, 12 Dec 2024 23:19:29 -0800 (PST)
Received: from HOME-PC ([223.185.132.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21634f24f78sm95135795ad.32.2024.12.12.23.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 23:19:29 -0800 (PST)
Date: Fri, 13 Dec 2024 12:49:26 +0530
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Clarification on last_comp_len logic in zram_write_page
Message-ID: <Z1vf/ladGMjeGpfi@HOME-PC>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Maintainers,

I am writing to seek clarification regarding the use of last_comp_len
variable in zram_write_page function. Specifically, Coverity has flagged 
the issue (CID 1602439) in zram/zram_drv.c

Link to the coverity issue:
https://scan7.scan.coverity.com/#/project-view/52337/11354?selectedIssue=1602439

Currently, last_comp_len is initialized to 0 but never updated within the
function. This renders the conditional block shown below as dead code.

	if (last_comp_len && (last_comp_len != comp_len)) {
    		zs_free(zram->mem_pool, handle);
    		handle = -ENOMEM;
	}

From the context, it appears that this variable might be intended to track the
compression length from a previous iteration for comparison purposes.

I would like to confirm the intended behavior here:

	1. Should last_comp_len be updated to comp_len after every compression
	 iteration to enable this comparison?

	2. Is this logic necessary for scenarios where compression lengths
	differ between iterations, or can this block be removed altogether?

To address this, I propose a fix where last_comp_len is updated after the
conditional block as shown below, ensuring it reflects the last compression
length:
	if (last_comp_len && (last_comp_len != comp_len)) {
    		zs_free(zram->mem_pool, handle);
    		andle = -ENOMEM;
	}
	last_comp_len = comp_len;

Could you please clarify whether this approach aligns with the intended
functionality of the code?

Thank you for your time and assistance.

-Dheeraj
