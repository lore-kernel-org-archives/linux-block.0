Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4C621
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727828256; cv=none; b=l4fBO9UIaphgB2C0cCUjRknMjFFcpxsNAdckG5rs0VgD4tEwAkQjyTjnblRiHfIXiU9exggKE0sftg57FzY/hhe8dqOj1s37DiFXyc0JW/2SMcK73PJXEB/WItM6jnAndaIhXHE44xhAsTG/H3vqh2fBqx+I1AJm+hEZdTHVQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727828256; c=relaxed/simple;
	bh=bqjymoWLUgT9BPx9mfQmqity+G/I9AivyoIfH5/73Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebE0iKnl1HZVK0xHDawXSTZdVDlkkasXNwsamGFzsarca0MlbfFMvKpUmlRtCte1644Ly5OcLggQTADHbMeDi8niCEJe5+eMlBAetAQcIBiDj3HQIbIIo0g25NYO9uRdIipqrUKezYWi8dezDqUA3dGfSG+gOZPgOjyZv2XY/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeKViwTp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeKViwTp"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e25d405f255so5307902276.2
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2024 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727828254; x=1728433054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3CbI0e+rpualwHb3sMc4Oy7JIygEJkXN1ZZxA6VsvA=;
        b=AeKViwTpTEz8jd+wIaGou7zzlJbVmmY+HXIfCbNt+83ojvtumfq6biUgxsOMHocPrp
         Z1Aksgb1AYtgV+DrYZxvOSnZFDZ1KOTd+YjNfEGT41v/Z+sYDPfytDjx0AtvYv09bR50
         DimwcmCpp9T/uSSqfpnhBXrW0HSwGwt4SoGttCvfYEm5/+lwzR7UvK+xcHd3IFU+rGNx
         +VALyWsMlk/1dx+g6J1d+yiraSdxLebqh4SlWUnhEGghOwsIFDCYQMZoO3sWrK8Jc2bJ
         a8FGQCR7U5SSX43VsSZ35+PPzB88DXJ3rw6dKXDyGg3BF/2NUJvf3C6UM/YoQTaTglZR
         tMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727828254; x=1728433054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3CbI0e+rpualwHb3sMc4Oy7JIygEJkXN1ZZxA6VsvA=;
        b=GdkDh9GuWzJnKd9PT5SZVeWmOIIRLwdKtuxvxV/zmDMsUQ7H2Nv1HIqNzY10dm9vO2
         rKkveCFAtJycGiGG+gE36HRAhwiPd22FbfBsUSpJyv30nEiQUISfmDosp3IG3Gf9qkBk
         Xkqij3Z8ds0eqtgX0Rqz0IpB5zi2vid9xXon9h071PXj+R7gsSV8zOf3e8rY+55EYMX9
         pivIQAo9DEzRR26kUXJgwO6JbDnbCK6EyhecW5fG2BBRwxSBIUbZd1gOtoOcFdCTDL/A
         lfi9xEgZyZK9ix801cJWtDfV2FSWdePW7WqqDE+mstEKlIDPKmlGKdJ56T6Vs8whoU0/
         XhpQ==
X-Gm-Message-State: AOJu0YxOY85SFq6q4IWRuOLQyV8srGneCYpMLqB3cY+DhxXrgkwIbF1b
	DxJz7ZpaVi0btvtBT8/UFLC50hZTM+3W3NXL8QQEmFF7dTxDPeKM2VP4Rn28G4JuKZTTlOKx1SP
	hP51oefB/695niyRMXWvqs6l/UB9J5A==
X-Google-Smtp-Source: AGHT+IHAHUIJPFitFlBmX4XURij3m8Q2IYN+KwNNah6k9Q8PiBhbTQuiKJeOearSY0PyWuFDa7HJHnzMhKgtF4qhuz0=
X-Received: by 2002:a25:c744:0:b0:e26:fd59:a241 with SMTP id
 3f1490d57ef6-e26fd59b071mr410205276.50.1727828254036; Tue, 01 Oct 2024
 17:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACzhbgRk9rzm0b6QdVdMZY-yk13nz+J9Uppt2pktQ3Hj4VBG1g@mail.gmail.com>
 <ZvyOP-3v8gjMlcU2@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZvyOP-3v8gjMlcU2@kbusch-mbp.dhcp.thefacebook.com>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Tue, 1 Oct 2024 17:17:23 -0700
Message-ID: <CACzhbgQ9gS3AbkR41myad3o1Qq8qpgFJzOe=AZGSL=mSVedkiw@mail.gmail.com>
Subject: Re: subscribe
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oopsies, silly me. Sorry for the noise :)

On Tue, Oct 1, 2024 at 5:05=E2=80=AFPM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Tue, Oct 01, 2024 at 04:57:11PM -0700, Leah Rumancik wrote:
> > subscribe
>
> Thank you for your interest, but I think you meant to send:
>
>   subscribe linux-block
>
> To majordomo@vger.kernel.org instead.
