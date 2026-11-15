Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794709737;
	b=rsUUcM0XDWNf9ouPGZ+j2Eze0SeU75fcryR6Kyj0GUXmdSdMMnyU9Whv/SFhRGhRPt/I
	 J74ODADCWhcv7wI0oNQO6ZZo5Mx8TjVEQlsUNoMcxBboetc9T8U0xYhWpAocTPBO6NI1V
	 L2/IvXWsGJZQyxEpMc6lXMbs1q28OpQMUq7dZolZ9XxRSUx0eHB+QHCSV/5m0guj3NFKJ
	 n9qH8QA2UbkFHTd0xCryqvpgYEbP9tgaw5JgwarvqI5UTCg+2SiJWNkorY9nw5WdVvXYg
	 p++Gq+15Pa8N3Auwu8oVDT7GA8L2EndwtXhYLZrjrpAtD7QaXjKMG70T16wajeDUQfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
	b=LS482lC/8qeKwF5fpEkw8LLcXa3Jbabn3pVuGFyupz01vu7Yr3o2ikgQSpwYQyoYY6+q
	 YtExgocjqFxedcFD7Dxqz5zn+/Gn4568sEASNQB7mTjmZ3bUqNCdsLZ1n1NVUmtY34ytA
	 EcMqZ2cUGN8rrlwUPW3HU4FWXT2mWUmq46eQQI23o0c8jdB9WINRH2R+PlJQOQJRp9VV1
	 iXtX7UO7mihlZ7gULVoq41DHgaATEzCr+3dlxYvWA9jVrjMUoqDknV+qAcwQL6WLvlMDy
	 a85ZfTcyBOhcXiAsTE2C5smz/NdN7ReWY9k4azFDvSNTDbj2BL2WODZmyaMX1eX4/6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbfneGYr;
	arc=fail smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFB606A32E
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 02:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAFB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nbfneGYr
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-71ad2c6491fso404968eaf.0
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 18:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794709736; cv=none;
        d=google.com; s=arc-20260327;
        b=hTwccu2lMLfEGKN4jp8KRbVjIYuBeEf2qRyVp/oBm7K0faNAZ+yhg2LqKx4wNzG3Of
         sNJ/wnliat8/ueXeH3ort6MdBmYGv25fUZpRDGgdxbfQ5foIV1CSQlw+HQrHTIEfM96z
         ptLQ34/fiqWMEglYajWDS8LRdhCrR5FJTPnHQ5zxO1Z3TktGBIdefi8b+jVjz8JNbl39
         oTcyHfTB5MuhnHqo5w2RrEF5hERcYEEC0ZPRm39rKvkECUiSXHNUmNqNdJ74BhziYw7Q
         DyjirzFtIidMiGnSyr1hN2ssvBZmIJfluYLAuFMI734xs2bajYe6XxT9W/aEEdPvp/Fc
         P4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
        fh=x89vDc4fenPi2AaIfpcFMOXY0pYh7Vt+LniykC0er8o=;
        b=Q4WkNV5WvnfX3ksaQf2Z57r5FMAjyRlciXvyvbIwecxxD+TZtPELLt8c7e3GwG6qT+
         cJR5jRDrpt5hfQXwaWjlLlOhi237e5ZfgVNHhp5XZHdYjQEXzFzVU4uU81LYCxEmDJOF
         NLCurDzLuX1uiSasScv9FEYEZOe/XFRbZH+cq6Q6CvT0v254Wsc8AteIuOkk0vhsv2UW
         s2ZDfvnj44eaZRDpk4y2Imou355/WT5VYVkTNV4zE6R4gcj3gJrCMbcNuRFJ/Mbjb0ll
         i03drbNCYWEd3ZZa8W8xTB2gsslRMp3EzYbhxhgtvsDhvifKoUzCj1zaZjgmvc6NGLQ4
         QFDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794709736; x=1795314536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
        b=nbfneGYreYpMfUAFkHDdlSMQmERdv23sSDuuWJ0gzACuRP9FFyRT1YhoCeaRNHI/jL
         GsNPvJ1lCij/s0E8/JKYBXgeOm98BmOsIqtmYEEd9Q11go5twbrwrZfHYhwsxndejGwb
         coGSqvOT/VjRhCiU0gDbZO9XzTM9tsW8vq8oPHjV11xIHreG57Y+9SAlELikVNansz7w
         DBfUMM01rxIJZvCOdRfWEtFTZUWi91j+FXUH6H2pFwKEpwV1o5EMLC3tREoEQjcKt6Rx
         rQ043/klYKCRt+u1wmVY8lr65wlrxV5NKQbmiv5au+/hyPqPvinslNUx6gAjn09+GaSY
         CHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794709736; x=1795314536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0R1NDMcyta6okyUda1y3v58EnPaSSc7GPjs8feVmgU=;
        b=Fhn8uBFWvLox/daJvEdulXJfWXo+rzQo0xtbhlY5m5C8jS48ydD8lLhlh7eRUIMbcK
         /up9uCT6CbBAktGtBZ1wWGeMUJG0LA85XJISvq7dQw6ZTCXPWtTm6FRmtW/31QcCB4ku
         mDL9/nqwXB0FG/Cmt5LxxnqKVpWk7wLfJnrCT+mKW3gXm62V2iZt3FfNvuj/a8rQ8J4v
         UqIJMjnlsVRuldAcZc7AyMOtVlKNBZFqhQ1pHgOekzXkdQ2k/Y4jtg07w2WfOqkChuRP
         F70tkPSG2kWfEsWe1rOFJanS6+3vRL6P3UPxvmmunrUkxSf37PW+fY3bTOWwJz+H4T8W
         nRqQ==
X-Forwarded-Encrypted: i=1; AL+hErEJSdZQlY8x8Jxy92Hv4zB/susTqFECIow7C7HO2GqmTMBHiy67KHkBDj9kKoRdjCko35m5/JN9lzlU3Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NDqiV3OGC+V2hWNrrAst/IqnVkcQlJuGo2/p6r6RQgDk5QEH+
	pEdFBPlaXOo+AeqgUqp33hpUrET78lD/R/aas7c/l3vvTiX+4cwhv9rHFSWORw75/C5DPW5C/vJ
	IB7zhH9naGDOWMkqUxWzvtx4qpKLeb5M=
X-Gm-Gg: AYBFou0tIBNvHhp8tCqle+nUAAWCPdzCEMHr0s7zwqRwlRyGEvNf/LCNjXoL26LrCwk
	Jfx/yF6m3WyyvrVo1IRKy2NjRu8KUK8mPV6oXbN3PTBSPdN6vMCsrFG3YCtF445gqPtMyD0V2Ji
	FGRTtnaQwjVz3dKYbpKPkcrhAmAs/f8wOg7mFfKugAVHA8WtDVLjeDCWu/Zofgb3ZowiCTSGnOl
	RSJkp69xTuiKMNGPu1+3DhZrPAGkrWMvkVpBhHjkNFJuBo0dqId8jwFx9VB4SikBFMUuN7m+9xm
	XZSV442HbL7h6d1JYbtiYzKnw+Ck1CnTsZq3pLbk3UolknlVclQ04Yf/KhrGGsPxUav14eGvl3+
	zvPGOjJ2zFktRS6sCJwK8BrboN/odGPaptClLN8qLHJgY5HhdXOJ9XfFdOB87X3REcJraPBWml3
	3O0/uNh7X0Ibj2R8PvnOZYtsAvokDSPOOI3gTJEfZWMdfrD/FAnN3EsbCiHA==
X-Received: by 2002:a05:6820:8105:b0:6dc:7513:c06d with SMTP id
 006d021491bc7-7197cf12f05mr6314842eaf.50.1794709735598; Sat, 14 Nov 2026
 18:28:55 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <202611112257529855AMDZLzg8ZmFDQ3fBstbi@zte.com.cn>
 <20261111225759742pwhACD8p_0GdXSYIk_Ob6@zte.com.cn> <avkT5yu3hJgi-YWb@fedora-laptop>
In-Reply-To: <avkT5yu3hJgi-YWb@fedora-laptop>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 14 Nov 2026 20:28:43 -0600
X-Gm-Features: AclHuK_Ifc5tkbepMLK0d8ZgWsUZJ0Zl-dFfIWODo7gKqOHzWbB2LamABucX8Fs
Message-ID: <CACVXFVN0Kw+jvDuZJB-XaAN3hNDd3WFvLZULJcpKrpz3qiehXw@mail.gmail.com>
Subject: Re: [PATCH 2/4] selftests: ublk: propagate stress worker failures
To: shao.mingyin@zte.com.cn
Cc: shuah@kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 8:07=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Wed, Nov 11, 2026 at 10:57:59PM +0800, shao.mingyin@zte.com.cn wrote:
> > From: Shao Mingyin <shao.mingyin@zte.com.cn>
> >
> > The stress tests update ERR_CODE in background subshells and use a bare
> > wait in the parent. A worker can therefore fail while the parent still
> > prints PASS and exits successfully. Calling _show_result() from a worke=
r
> > also removes backing files shared with other workers.
> >
> > Generalize the recovery PID collector and use it to wait for every stre=
ss
> > worker in the parent. Return errors from the worker helpers, leave resu=
lt
> > reporting and cleanup to the parent, and reset the PID array after each
> > batch. Keep failures ahead of skips when collecting worker exit statuse=
s.
> >
> > Fixes: bb2cabf23568 ("selftests: ublk: run stress tests in parallel")
> > Reported-by: Ming Lei <tom.leiming@gmail.com>
> > Link: https://lore.kernel.org/all/avJ0Vn9G7XhZv-XL@fedora-laptop/
> > Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> > ---
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
