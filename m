Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A26330305
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424885; cv=pass; b=P+pJocYDEGTnmFDBKJPVv47H5T7xffrFYCrM5vEWr2Gt83bLUE0NgCbdRl6p0c9E586UK0hcK5m6McB53S3g9mizzbnsyh9no5CpRF7gb+RnmNhEK1xh7cem08zvRsfcvjqGCIxQV+4ajcjXoEWtoFzJW8r47qzTPYZIiZj+W08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424885; c=relaxed/simple;
	bh=3omMcSnzzBOB/jU4R6Db7fut+Zs1dL68KtxqM98Cvg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEody1VUP3TKpwCJwlJLu2Ak0jMns0rvOaTNkLOuO8XXc/Bry7U4AP5G1+0wjp+0q+27kVI+nqzgVqZDlHYXSA9Hc3sFSp02s3kLjE3ojyK7V3cqfW6guBct9yby2dMNwH5TrzajdQGjw7kYeBDJkG3rNglVNxGD3+tmkhmy2vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDwcCI1z; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDwcCI1z"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso7695231a12.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 02:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769424882; cv=none;
        d=google.com; s=arc-20240605;
        b=cRnaAQ5cHVSQn5CeMuuYjSu2ko4Qs40yReLUxsvIjuHolJwyWGaR2mLZBiBNVu5ZtE
         h94Fg7faK4hd8i3Br2gwJ0e9tQwjepu+r8C5esxFgrcMRVcuz1x4aD+enexl9A4OM+Ey
         M55gv0UMdVS+bAkA6+FIDWuIbae5VA6Mw1TObkCuoCV++JjVra2IHbOaXZ1VWuuO227W
         Obu87svnZAGDLiMg8fe0bWCj4+rwOmytvc8bA1f1WCh2tD19dprPx474Aa3kP8+FG9Do
         hhpe9lh5SO5hlsrlLvT2WEzU7E8MPWFT7bq/RqrEKWVNfy0H5XJ/sJqUhx5VYAijJ71T
         E1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yNBCh+MzIZqXXtP5FXW5pr/v9SaMB3DIQFyJVa5+MmY=;
        fh=za3VW7smekfD0sB84rsU/naWfdrVi97qC6x63aTxgvw=;
        b=VgzDABC/F40/BSGuHpuo10HKUuV1bIIWYuxvOXGEv97dbyz6y+qsTvxz4abYlsS9tY
         jekb7+EifA/yzykGrqeKIUWBebYR0gDhY/ce7xjcsoit+sU79/fqfXdJ7RGrq6OlSOn9
         BUl7hlBXN64MMvDErutdeYyzvPP6AYLz1q5X9WjCudfXjpvYD056nOrtonbsvrOoH0o9
         f+yfqQxs60vTJzVcngc3M4zT+WMeVGo8abIQHqueh51BKdm+68d3ToauWaGOoJEOpmeK
         anIzfSuoJsVNOsC3qwtpQ/L3xrTFKH8WlhQ7BaY5t2bwfa9jfizEVczf6ZfhqaFaPJ4Z
         a8eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424882; x=1770029682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNBCh+MzIZqXXtP5FXW5pr/v9SaMB3DIQFyJVa5+MmY=;
        b=BDwcCI1zcwMS1r+JBTzVcAgOhhCyKy0iK3KjR7cl4JIukj3SmH85AXv9o9B8g1qctg
         k7izeFCcTtPCcQtECVeXoH+n24rzuwNk8c9uqRbQNFhOjscE+kr1BAy4gEqD7omZkb2y
         dactuQd5KyDLfPA1OEwNuUMSZ9eRk39Jh+Q/gCPk2LrC9aAEAoMY562w82OB/4q4YB6g
         ol38PUksbxt0njqtUvypKopW88GmE/q9XXJ3pWhOzN3l8DKqd0UCXlHY/CMu2WImU2ul
         E5MDdkm1+mUS25rqM+9YDj3y0VXgB+ZMpT8mE23DvKrUub13/KaHHX6oli1RGkl0eUl7
         qyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424882; x=1770029682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNBCh+MzIZqXXtP5FXW5pr/v9SaMB3DIQFyJVa5+MmY=;
        b=oyRSAj5KfhB2J1+1gDMYenAZD6Jdkx6rcMYREenvMC/8u4q7DF1ID3I+qAohHUa99i
         oq+h2SiPQuDNvYrGEty5V55UEFMtScSFCMTwWqKe2+CbrFyrbAscK0bngZ8m5wrXsf5r
         EEVTv5Eg7OGKMwWqEHNqi6fF589WSL7FjVs4mzq5rVxDMYbLy+3NVf446LvNrQiOckWy
         fyYILv9qJ8MItgoBvdueFhuFY45dYmcQUtFkl3ueO4PK9XEtFflxIQnDWff3Vz0m4Oxv
         v3pP0ITJNLYkdmH5ayfpgb4Bh4wF9bXj1mVtJuced2/ZTY6ieJOA+PbbcP8YWO9zaCKr
         KYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxg4kL2idZnMz5ksGHYSQysikUdHnom7atlT7UYC+uCPjxay/S5TLWhHt4rdcC+eAnJ/dvJj3ORmq0Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YziPEyyihJ3WZ27hXjLNxao7/SEFEErvhPNNdMwYKUfsJXdvaw1
	QMtlv5fhAdVqt9mAsDPa4hoMC4X+gqKe4tbFFGG6LNaKXXPyKxgUVcVAvdGwvXR/LAsqpsLddoz
	h8b2XA2d/GLFwyESOEL4xv0HbmlQ/RQ==
X-Gm-Gg: AZuq6aJVLOXnylhvC3Y+503NZgq+n0zVnis3JbbLgyV7ALX/EOXxcMcrkxgHzql/qj5
	rB9IheKbOHbNt7cyALMSAJh5QJEn0OKSqrqAAptAPSEPaIT8HYUr2ZnHpOg8Nh5kVgrVUPcm3Ym
	zzbUn6hUM/p+gyE2OdMcMb92flAHUxp5nKaahT7I8iN6F1ohVTBDfr3VW85m/zLp39NF9kc6wOp
	hoYlM6XOu9r6EDV2S+JObCps/KrFSPqtBiyR6yQxT2JJuvFXUCYXrgxkxOhI8yoJNYThHUvq1bF
	8T27y8Yx2Ed2etfaYxdsAktLT/o96h1sNGq3ZsWwg9+h2UGg+oqqW5dj4w==
X-Received: by 2002:a05:6402:4306:b0:658:1224:3d5b with SMTP id
 4fb4d7f45d1cf-658709c0267mr3007632a12.1.1769424881479; Mon, 26 Jan 2026
 02:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126055406.1421026-1-hch@lst.de>
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 26 Jan 2026 16:24:03 +0530
X-Gm-Features: AZwV_QgJvnXLJlNIFnJC-x5vJYhiyLLjRUKN4n8q42zV9yyRDXraubp27mNNc8w
Message-ID: <CACzX3At3fS19fmp8wOq29rHK-yw0KFp1bAvTdo9NC9eQj4E=pw@mail.gmail.com>
Subject: Re: bounce buffer direct I/O when stable pages are required v3
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As Keith suggested, here are the QD1 latency numbers (in usec)

Intel Optane:

Sequential write
  | size | zero copy  |  bounce   |
  +------+------------+-----------+
  |   4k |    8.91    |    9.09   |
  |  64K |    35.98   |    39.9   |
  |   1M |    341.96  |    531.51 |
  +------+-------------------------+

Sequential read
  | size | zero copy  |  bounce   |
  +------+------------+-----------+
  |   4k |    7.18    |    14.28  |
  |  64K |    36.4    |    95.61  |
  |   1M |    206.38  |    258.66 |
  +------+-------------------------+
