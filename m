Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A51CF83
	for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673248; cv=none; b=dP9eF9Hk4+t+1cUFqJEk4OCLRt3pZZo96q6MWc1PJd8GcUtKgNK7bBEno1pXgzU7rtwiGFGz7tQYomwJNY1226MKJ0dVxK68oOqGBw/z3ET+zedDW3CVTKYNShTLzO3O012H4qLhmc4zXGtb5TCXTK/qy/RoGZzMRragt7Ze9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673248; c=relaxed/simple;
	bh=MSU5S4V+t38USte59PcMgw5GmQljSrHol8w9IdUg2XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0cymdcqyrUDpY2j2ITjFzQt4L0WIGK7sZwxwiPR6hb01iIIKBhLixn3SE72Ri+CFbqkfp844BrPHgU1Ucw3t/u8ZHuB7FEBnia5ARLsu5eGphRE7i06rmybZjcfKEWVO4V3quXVWqrS+Y58144YRRgvXlq3BRwbsa7udE5f52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hEj0UYvT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hEj0UYvT"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so2349573e87.0
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721673243; x=1722278043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYMflACHpw89XVKfwMzWogugqWjlq2hKPfUFOYlPunM=;
        b=hEj0UYvTppjNoiu5CfbqA2wjsCzA+WIS6adOV+tH2R0JxJw4e9dU8cMfHgiEwJ3EoV
         3t8cdjjukzRalhOtvCs+cSHbxcjUV59h4k5xsmzUD2+QUhA6hNdjUIpnR5ZHn/8OeEub
         vkExARM5EFgngf/CehWnV+5B51q60pwTFC9Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673243; x=1722278043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYMflACHpw89XVKfwMzWogugqWjlq2hKPfUFOYlPunM=;
        b=TrDhpunwrqA741t6+T1oM8JJ7QHeKSuN+0Jql5mnVzL5qoV8W7+D3Pxgo5kMy8k7mA
         8T8N0pYVlT998PjqhYvKhpyXhMZfhT3yvWvrrqeMfqG09bdEWEIxDdrdC7Qo8HlmUIZ6
         J4mfJ72FIwtfgt5LaqoKiPMf+0HzizNqK+nI6C1P7uvJx6J9ltoU1eGwH+Pa3xSU/e9p
         itDNbq7hUf55JEMZ8bG4e7r3EmQJ4QdyEBU52wxzYyOn+wFFoizrE3gGib3iW1b60anB
         rk4krdQrSPDHMNrC/x3xqqb7lZfdBQbAdZWs3vDbpu1fD2KQJnG7RoBv47Vj9LVSLZpX
         vNEA==
X-Gm-Message-State: AOJu0YxGSlLNeCJZkdwR38VtXPKnTSp8o+yvjr1ZChT+OLWzinm+XYc2
	p+H2FL3MuToI/38C2tjxs7jUVCkYI6fC8qBIiIvkwgVlE1tfd+8f2IQleYcPCGAnCqDR5ekgpJe
	eIfM=
X-Google-Smtp-Source: AGHT+IHb49lajwvwa6aZeGYO58cJOnlqLLp1XxMeCSMc5uDghsv4gQ+oShJVEuFn5C7MZ8PPfOw+rQ==
X-Received: by 2002:a05:6512:10c2:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-52efb7cafdamr6261237e87.52.1721673243243;
        Mon, 22 Jul 2024 11:34:03 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785d4esm450170666b.31.2024.07.22.11.34.02
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 11:34:02 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso1906168a12.1
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 11:34:02 -0700 (PDT)
X-Received: by 2002:a05:6402:35d5:b0:57d:3df:f881 with SMTP id
 4fb4d7f45d1cf-5a478b65c3amr5392684a12.3.1721673242210; Mon, 22 Jul 2024
 11:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <505fe3f1-27bb-4791-b4c2-12c99d0da624@kernel.dk>
In-Reply-To: <505fe3f1-27bb-4791-b4c2-12c99d0da624@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jul 2024 11:33:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqD58W_cn_2vE12ZGTJHboT+iQ4SYC7YPTP6ApXjB8bw@mail.gmail.com>
Message-ID: <CAHk-=whqD58W_cn_2vE12ZGTJHboT+iQ4SYC7YPTP6ApXjB8bw@mail.gmail.com>
Subject: Re: [GIT PULL] Follow-up block changes for 6.11-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jul 2024 at 06:57, Jens Axboe <axboe@kernel.dk> wrote:
>
>   git://git.kernel.dk/linux.git for-6.11/block

This is not a signed tag.

You actually meant tags/for-6.11/block-20240722

I've pulled that, but please check your workflow and correct whatever
went wrong here,

              Linus
