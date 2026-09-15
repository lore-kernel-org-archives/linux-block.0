Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CA84D5A1
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455323; cv=pass; b=NmdO80XegzWudhtFJufVHcdLPG0KKwvaBNJIQVNDAcatcXhzLCfI96uyOQBPVgAXhZWnyV+aB1jRrariNAW09vSuiw3TJJDARL1TWXaitcU1MDBb0x6bhCevSJv56lEGCERnyanNra13+xKe1GV7xuFud15yvei3zRAW/aypkwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455323; c=relaxed/simple;
	bh=vuw732qMf2jkVrSLeOVD6dFD/8/WEX9xRAVPXr8U+qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoUgtd18gQC+l7YChZfTCxAGxAPyWo4/1nfirf+coLWKPY1uzFBRXCZ6Waj846sozThNZ8x65jOq19pzIWgbzfaLlGbt/A1tBIK63r22CaXtiDzYzY38tz6zH1XW+MR/X+th5K3UGE3rZc+KZhK2Pw3SND8is/D4brHeW/uiLvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyJAr6a9; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyJAr6a9"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dec5de01eso306890a91.1
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 23:55:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789455322; cv=none;
        d=google.com; s=arc-20260327;
        b=V9wiATqo/ik9Fh1FzNO80ORZxZzRBeVlAvAtzKyyVQ/aZSaoIjJyQ2sb6T2Rr9vozN
         QUhhmGjTJ/qAzR6NGWHZgkqCB61LQ6qZ14Djy83oWezokFuU+Rk4JpIEnYS9hDntwhrD
         pt+K9okR41SmM/rQzDPZFc0m57yTN8gRhtTVOCNnisYapcSYWWCSSnvm4qYyDuPVdsWa
         ZEuCLXklm9hZ1ZASv4wNXJ1oheRPFnY0m4X8zhhm/sG8+axxPbR03FFHffv1L7a5iD0C
         z74/RMA7H1tuJlKLvhptInH6RHbH4KuAZfc163a1/LfqQyoUW3SIa7q0fLJ4v3iM4T0P
         3joA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vuw732qMf2jkVrSLeOVD6dFD/8/WEX9xRAVPXr8U+qw=;
        fh=rTNa4zCn6xVM/E0S8C+GA74zey4+sOsND2KhzFVJ6Bc=;
        b=BUeIqjS+6K+xamrX4Hp5922EOiGKvu5qqyHwNb3q5gIvai7MLiMeU2j/ohamarYZgk
         ba3fVbiRrsaXZa6Ci9svXoiptLs1v9IQlo6s7BImNCdqylBG6JUAD6x193DwDRec8FWs
         cAtXSjnzFEt7+EMt9s616mOzQL73uQL4KgMLo/tK+ICaD9VWtXqYaYOeXdsNrl1S6gDd
         9GRzj2QyA1PuXjKCWD3eDyl5IwJgBMgTa/+lAZkqxigdnDeinBj4KFtj7nh0yT6r8gsq
         42lkvzgtv9eQLung2g+Oyka4dZurtRJWvhp/NkoeZ8S3E7b2SCru4XERcEKIemBCpEhz
         Ptvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789455322; x=1790060122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vuw732qMf2jkVrSLeOVD6dFD/8/WEX9xRAVPXr8U+qw=;
        b=NyJAr6a9V8K30qiRP5CV9iYCrZvDm7EXLZtD657+qYi6WN/ObaY56kt3GhYTv4Ssrb
         VL7gyOnU7/OfKPQKpvRs+dSRSzXRkF2ISQLUUcb9IU9dWxGTCqVBDE+BWmBRhG5wPplH
         ZFYoQC3YfbcH1fz0yeP+7EGElUqGqwee/wqizj/dwNyqL817JMllWbUMZpWTrbKJIijJ
         sQl/tOb+FTFc4qXmrM6+FPuVVDcNoKSOWdPYW4SoLQ57WHiNVPf3lgbZ12E7Vls7APCp
         X/ThwcIj2b+6FB/B6LDgjyRfjcFeXBmkwWef3zN6xddj0kFDsPZpKWVgJ3P0R76bHIya
         X3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789455322; x=1790060122;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vuw732qMf2jkVrSLeOVD6dFD/8/WEX9xRAVPXr8U+qw=;
        b=lWmIeoQkn43RhCZ1pGqDREX3iPwnd9t7PXnmbuU2Lr/0BLQsEDVP8DqlNnYphVODA6
         F3P/fBtVpti7P4n4/BZQD4MkxjeOGlccG2VDgWUQrBH8Tf41Ag7oohc+e0MPOYSr6Rt/
         NNKalz6kotHYfAS/MmgdpVoVu78Tv6nrGxTlBqUQ6LbmxRxSaz9GHHFtIcsrM+P03YU4
         veAAH8kI/HGAIDgrGvhsRVYNNwAxbOYKTL96vrSodvmrlK/98P2xHlhxxMA0xyS87CtN
         /W50FVgePho6ENJ1B2V5syNlUt0MM3d3I5jS056WEz6jCCCZfL76loND7htA6GcCQJeh
         dF3g==
X-Forwarded-Encrypted: i=1; AKwUvBzEfk4evBo+YR31ZDCdp4oXsKT+e65s/sbK38ewFqqv93Y60wARD8MBB3DAwGSCL0YQHmViGAOllKt2BA==@vger.kernel.org
X-Gm-Message-State: AFuF++mJeB5skWEpIsBKIOJGrDS5fSbey410c8NDBsi9x8DoVtYnMlj1
	vZQ/qxa79fCnYmZN1varDszLySGjYOgsTJo/OuHNiZMGLzQPOwoP14iVFm5AkMRzVOl908m6265
	QUC+M/m8tGiAmiuyciH0Jl2nWc+OnM4k=
X-Gm-Gg: AYBFou0AGkfXEzShWhftckUEZMIWbr3aplSsrmZlCP2APynrtcENX6YKkHfjywNxqiL
	CHdqJPZ0ba9jBnz3vMIRrfkUyM3TXnXtE6dTC7lWgTBlqDnaMpcmFVMzk60RejIxIRNyCw6Dy/B
	4FK36BX5WGPC2KEDtsuOh8WvxAsX8ZETKLKelZ2fHEq7A9+zeptswPK9TRdWvCGaEYnoi05AHEN
	zV6zRDs+8TdB2FORcezIa97mWekineCA8LtLR9v2PyiGPw3NKxN4IezAv/oyaalPksYFz2v5AdM
	tdEmcmACndBtR12gkIFfR5hxA21ijJUHqw5xuFnilRTitlTPeEuBctWOcPOHM0rD2difaOkwvGV
	lhn9xVb+v9hqgKvhQzPlp+DLxHG/q4ofw/CjA9HdQCuKg4YmQn/vH1kd5UroyjvQIzOQcbs/xin
	RSsyN3SNpz+kaJAwjZbyqqSEx17MX1BlAYqVvEM8eNj8nNjRMyIg==
X-Received: by 2002:a17:90b:2742:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39dec24fbedmr8075100a91.5.1789455321609; Mon, 14 Sep 2026
 23:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789420324.git.pgovind2@uci.edu> <f515b62bb05e7b6bf0bb06c8fdb362486fea25a8.1789420324.git.pgovind2@uci.edu>
 <CANiq72=jRupLtnQSnAewyZZC7q4-oeAVmA=SfBGN+z_nefsnvQ@mail.gmail.com>
In-Reply-To: <CANiq72=jRupLtnQSnAewyZZC7q4-oeAVmA=SfBGN+z_nefsnvQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Sep 2026 07:55:08 +0100
X-Gm-Features: AcwNN1URt2QYtF-NYmCB88MUGiPqFKp9kgIrbK78hsZ0yEKNcwWDtkaTsv24RvM
Message-ID: <CANiq72nPhNRxesnUQ3HKBxtfxUD4r5rPYVQOxbiOAvpEtzUrbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: block: Fix unsoundness in `Operations::queue_rq`
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: a.hindborg@kernel.org, boqun@kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu, 
	dzueck@uci.edu, 
	"linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 6:39=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Finally, it is usually nice to provide a simple example when possible
> of the safe code that triggers the issue.

Ah, in case it helps: the cover letter was on my spam folder -- I see
you provided a full example there, thanks (it may still be nice to
show the key bits in the commit message, e.g. the part of the impl
that goes wrong), since that is what will be kept in the Git log.

Cheers,
Miguel
