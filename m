Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15D28628D
	for <linux-block@vger.kernel.org>; Wed, 19 Feb 2025 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934293; cv=none; b=PasDvTT+CbInnnIwkTGN9cNS/TgI/UjtgnsOOq4WoJcIHBTDq+7KpIQZgET+5r7x9veTvONzbKTnOkRIfNRJZxmU8+k67dorRAcOlLBiGS4v+2cT9263BQ8FWu8VGWhXypkoKt4tRuojx7JVXdMiQnJYEmIPVgZIfy84GkkBh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934293; c=relaxed/simple;
	bh=QBu8bnVp7cAAz8xvHD4+V+gCVvlmoZ7hW0/gQcIXuEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdNrikqDsK/AS+l8kAujdOgG3XWArcZQB0VWirpigV3ghB/glvtoX1WndB9jU+1Iy5/csqegP/OLug0IPFZyTdhuOvsGzFH6ha/pYJiCxan1qoyl9F91gJvpr4xjAds9EWONa3ROLYL4K4XQz04i65nvI2PChqFxzqTR7LquBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fIJvZ5Hc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fIJvZ5Hc"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so1416535a91.0
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 19:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739934290; x=1740539090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBu8bnVp7cAAz8xvHD4+V+gCVvlmoZ7hW0/gQcIXuEk=;
        b=fIJvZ5Hc35+fnDgvhNxNaqctehBa0ApLT/cwuw/95p1SIPny6321d55fEc1I4GE9qg
         DYnzCmb226iRiTFxW2bc5jC0o5dCcCYI5sk19Gwi/tlUZSzrC7qwMHQytATwy5zBHydq
         gnp4PWDcKmAdGJWC2Uy/5C/IBkrNHYhsUIwsjAgT7jsfTB9rcjM0qQLA3SjHW7OqBtxh
         dlHFOAxC8Ab1s/WF4jjCNRPuIZX8zT5+XPTKhE31KGkyIxaZihfS6ld2EFVJPL1EsHc0
         hPEbmz1LuFyVc/P85RqjeT26pepAJrH88LZ2Ik8ywtz7KWLFLhYrAAJ4nxVcfdpJJWku
         Vwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739934290; x=1740539090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBu8bnVp7cAAz8xvHD4+V+gCVvlmoZ7hW0/gQcIXuEk=;
        b=V2JK1Xo5gGN8ZyIiIRHoKgdAeXKAx5l0M0Ly7k+TwUgVRs9VIJQCS5J3fdiI4JTCCi
         Y1V5RGAipT9bzSioaAHCPnhuXddg/tCVyK4B+emrb/9cvifO3QqMra1RtUFJj9fjGI24
         Xkf72g0K76Hv5wbEzd0g0rEIGKB6MITwdfD2YY4KOp+4cs///q2p7UM9wZwvE/5pexG1
         ItiyjPDBdQlGBu9iJfXvqmFwceKPsxrVMnpIupvNUIWyg2SITxam5CNqcjyytskkagca
         NNabVILducvg4SZByG+CXyFI3rVtseAf4R9tbg+WMdWScN7YD+13rOZWawCUatEJypJQ
         qJ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUgNnQPpmTYQbgtczYHBAD2sIUHC3rho1Wnuo90m3FaBqfglu394/tWZzERGymi4ySnZqhtILVLiQOPGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0NA+xzLuKB5oUngX0XuiGsRLyA78cvUhqUlctrA8V15tn8d2
	IotteDGZMlpMwosfP77iA/+rHFJp+ZKbXcn4gtGChKBBefbNoQ7L0kjkAH8H6w5HsozeoX7jjYj
	1SiQGrNYptvZEsEuVccmUrCZ0HXklaDX4VBbNhqfB8fXCaHcNl0Q=
X-Gm-Gg: ASbGncu/8BpecKjsiPOnRQdt6HH2qN/Cd/RCBH+6LT+FCDx2q4+7NKrqSRlpY6Ssa8o
	Z9Hc6QJ/jhDANKLQ7zFCfL7lDvX0keo/WjycjHJK7t53Jkn+VnGDCAyy9XShGANX1xdYgTZw=
X-Google-Smtp-Source: AGHT+IGbWfBTv3bJQBkLTddEsKSVQYYxX+1v0Zon0lOuA5Y7+jEcvxKlg5Z3EeTmqk6WIAlhUNG48r2zK9MjVfqGcQg=
X-Received: by 2002:a17:90b:33c6:b0:2fb:f9de:94ac with SMTP id
 98e67ed59e1d1-2fc41173a82mr9136423a91.7.1739934289773; Tue, 18 Feb 2025
 19:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218224229.837848-1-kbusch@meta.com> <20250218224229.837848-5-kbusch@meta.com>
In-Reply-To: <20250218224229.837848-5-kbusch@meta.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 18 Feb 2025 19:04:37 -0800
X-Gm-Features: AWEUYZlhpbl6zo51XLc-9LNMQhJtbstaAczwolRE4Vr2WBmTwGh9LK-vpcwr_Lo
Message-ID: <CADUfDZp0Q+Dg5jOhDpOAXpmPxcywS6TKajTgw95qZdAaZgn2sA@mail.gmail.com>
Subject: Re: [PATCHv4 4/5] io_uring: add abstraction for buf_table rsrc data
To: Keith Busch <kbusch@meta.com>
Cc: ming.lei@redhat.com, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, bernd@bsbernd.com, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 2:43=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> We'll need to add more fields specific to the registered buffers, so
> make a layer for it now. No functional change in this patch.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
