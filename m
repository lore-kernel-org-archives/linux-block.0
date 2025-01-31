Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABED22615
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738353558; cv=none; b=FkXEfxFF4SErm/MXl6d3vwR6HKSKI3eVCKEmbcJ4/BZmeYEddvlvFXN5lDkUnrC6YjQ68dJzr8FpTp4TCk3uLuZ8q/dka8WBue/uRO7H0BQJxeJDDZoCjDG8R4Nc170OpnoeqoTbM4M37zZyIEWzhBQrqjPoZTyBeM8iFOQrpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738353558; c=relaxed/simple;
	bh=17el+ADTwxXBp5MOIBwfzED8HdqlGU895MY2gC9ezwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpRCmh9R1GK4Q1hgCr7b8fWj8QB0n4TZuR5P11/5D93jDHcLNvyNX1BkKf0C71JjhRvEuZKeJXyiPjadbp2tZ/L8r185x7EWmjxdPUpVCIhhwq7rLwO303HPYgrTcxIcUGezTVYQrIQIyUOb82i7boiM5ziDuMojDgBC7Vd39BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/CkH6vM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/CkH6vM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso3187637a91.2
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738353555; x=1738958355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17el+ADTwxXBp5MOIBwfzED8HdqlGU895MY2gC9ezwg=;
        b=J/CkH6vM1K4kfK165TJ65xxlPwT8iDGFEpDJvSzzHoP8tB/p7sgWRzPRpNjKDuD6Bv
         ooUeWYAvkDwrr6ixCESYVfUl1U43ONrnSEJ6hK2+AjLCAYptmkwcub532GFjEp3wm11A
         k14FEwgLdok/ckzUCTJt9C1abEB/Pgh7LLmNghO/RKmkNIp47e7al5RAA90UdVYid86U
         tD13MLMDuExrxXf4l/Njyeg3MKT7XVkaAXVqdjndUEotcLdRPYFRPHfxCb7a72Mq0vbk
         XFl55L2HlCmaosOdI79quGQPUk4r/lB6utTSf81o3h/VaaSuXJqZDRnt9M3ieetOIW5o
         0c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738353555; x=1738958355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17el+ADTwxXBp5MOIBwfzED8HdqlGU895MY2gC9ezwg=;
        b=f10OGVjdpjWQyOrSdDoPxxP3kObkoc81lq07qmkxoxbcusAnE1jwc2NU8XT0O7H/74
         7nBo0hBssjkPTleNzLNJMtKaBwyfEsS+mJrmd4gkL9QX+LLh/iLl6wFUGgAvCxA5uLab
         aI825If6kw5yNjpp5N/EV1cIMDETBO8wYTBa4DWCtJMov5UX1SnFD+ZW/BpgmRI613rn
         LuLJ3R/oq8e0Am27FcggwqYp6QTf3HI/Z2tflyeqnOhAPyHZqlXZyQLSR0JNkBcZfPgF
         9a0YHx/EF364Uh+QTaHb8YHMhfYVKaBVuYC/IjEc43U7qR+3BTiHkkAIRo2Y2W2hdxe/
         h5ig==
X-Forwarded-Encrypted: i=1; AJvYcCWv+eaRUo6cVD29g4eXufPx0WyX4umTUbuLiBfR0UVtYsftT72zADm+GVJnebARZ9CgcPyZall3NVERPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4d4QJb+M8YeP29HqgtlpU0nlTpNozIVR7Jsm8wLttoZnv1fJb
	trIEqCRVVYDYqVKpfpIMED/uhUF+VLoqj55i2/MJlX6Dk8BdjMymcK9WK1dRh/4+WVKHFd+vNm2
	i3t0GVyiWf1OTBkPhrze6L0IU4jYkYfUX
X-Gm-Gg: ASbGnctrKNQBS99uYrD3cwLlvWUCsi9WGapf4CIY5bmgIjlKCG/KKoqx9ZZk15XpvkP
	U6f9ViRH+VPsq12yYq3G4Okvsh89l/NO3tEcvf/aSX1smsLD7HtwmmVWXlRRAcj6SY0JkaEc=
X-Google-Smtp-Source: AGHT+IEdz+PUksdDfWR4Ut69T7hAs/nk6qgNXncnnf/UaAPmP4FVOrqUe+Cxrgi4In7rmdxq5b7K/K2hnW+gUEh4jC8=
X-Received: by 2002:a17:90b:2f0d:b0:2ee:45fe:63b5 with SMTP id
 98e67ed59e1d1-2f83abbd6e9mr16489290a91.3.1738353553920; Fri, 31 Jan 2025
 11:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOBGo4xx+88nZM=nqqgQU5RRiHP1QOqU4i2dDwXt7rF6K0gaUQ@mail.gmail.com>
 <20250109045743.GE1323402@mit.edu> <CAOBGo4w88v0tqDiTwAPP6OQLXHGdjx1oFKaB0oRY45dmC-D1_Q@mail.gmail.com>
 <CAOBGo4zdDQ+mV_5X1Y0J2VpV8F63RsBs66Xq4CHPtpBu9MFebg@mail.gmail.com>
 <d2951075-e9e8-460c-9dbf-34bfeb942aa4@acm.org> <Z4Drg8pewTBbs0sy@infradead.org>
In-Reply-To: <Z4Drg8pewTBbs0sy@infradead.org>
From: Travis Downs <travis.downs@gmail.com>
Date: Fri, 31 Jan 2025 16:58:37 -0300
X-Gm-Features: AWEUYZmsVxC3Fi1GEkd0v_5VCxWz2PQ1H5xcQjXI62xu7O_gMUebqyAwQ0FzUw0
Message-ID: <CAOBGo4wRNmMNy1ArCXphEpV+NrcJ0nyHtew6nwJLeJYGqM7fXQ@mail.gmail.com>
Subject: Re: Semantics of racy O_DIRECT writes
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, "Theodore Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:42=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Jan 09, 2025 at 09:32:54AM -0800, Bart Van Assche wrote:
> > in trouble. Additionally, since typical storage controllers use DMA to
> > transfer data, and since DMA may happen out of order, another pattern
> > than AB00 or ABCD could end up on the storage device, e.g. AB0D.
>
> Only when using an LBA size larger than each chunk, e.g. in the scenario
> mentioned by Travis if using a 4k LBA size and not a 512 byte LBA size.
>

Thanks Christoph, your reply is appreciated.

In our case any pattern that is ABxx is fine. We don't have any
expectations about the about xx part, it's fine if they have a torn
write, out of order write, total garbage etc, but we'd like ABxx to be
intact (see also my coming reply on a parallel branch).
