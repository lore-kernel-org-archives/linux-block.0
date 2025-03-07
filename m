Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4915746E;
	Fri,  7 Mar 2025 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389283; cv=none; b=uwkV8YjGG044aSjKIbiCEm5Es8BQWHa4hqr5zZ9zB/R4lrAEsOVwaKrqU71NNkJpDWy6oiAH8mzUoyKyEWUj/0FKnPS7wy9soxJL5fXXtA8rh9hm20WX6XMftyEaq4btNNy2CljngY8rITl4d/7QxQ9HEWKvjXgpIdcnctSAhYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389283; c=relaxed/simple;
	bh=hvlQKLrSiuf2/LahHmulAvjGAEyNjmerVi/1M7Kc3Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck72mxrjswiWwdMfUF5zGu0f+3vrEzREH2m772XazlHneIlhWjg86Fsp8uwd1XVTc6l5kxrtXFIkrQf78agNjqtVqCyOv3eWL8znPY3eDG/PWRqtDMJqitsHc24+4njt2r1XSuXa19LzTjhDYyulvy0TUnJe6FRWNTe35A1mjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H71nba+x; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H71nba+x"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fca43972so17646196d6.1;
        Fri, 07 Mar 2025 15:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741389281; x=1741994081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvlQKLrSiuf2/LahHmulAvjGAEyNjmerVi/1M7Kc3Yc=;
        b=H71nba+x5kUM7iNlAArjbCo9ErDcJxx2ajnCqxEwZ9E9rW7c9veb31nt6fIHPEDBEn
         mwa2NP0IbY4Ja+WpzMMXNq8z+JIavfCKCKMdhe6M5oKJ0TIjMYBFFAvm0ZMqt6YA4zRM
         C1Kd4msJBog0E14t8njtIpU2/UuUA2DNgw0E+AeSqri5H3MKn8rgIhKyHfybSrYWVnFn
         SfM7vF1fRYvlWbYNL6GDlbiHOQGHu1Q924KfZ/cETaWEPcARDN6BRbCL/AB2ScRPZDGD
         y6V9AIw2X1ziy53e5t68qI+pczPCgYfAKP9s1YaYURHZ95cswLbuOOtVX81LVIrSMuqT
         fG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741389281; x=1741994081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvlQKLrSiuf2/LahHmulAvjGAEyNjmerVi/1M7Kc3Yc=;
        b=XNz5xL4uizCXQPlqYr/uyv+d56aTFTPDQC0mcA4LQzs30JpvQtXwlvWhz5DvtXHwGK
         S9jnthShuVhEUn+SOjzrm2fYorp0dai6lNq8JkXYLF5qirUGdcBG2IizpNvy3HoH1mSs
         GRJeaI56x6ZFafLFwYcx8aaTAfZLVrhP+Yn6GkDFHYcPySoAco2ky/O04HpKvYhzFNFC
         5gpDGesVZjyq4F8xpYeDImrXK9h+MpnMVlm3CF2Fifg8fvAlPh4L4ksRHoE/6MRYynM1
         4u8W86eP2UiRsdu/PmVAayj/QZD92JJOpj1RzASQfZ/O5M2qiEXFl7sVQWY25HjsJxlU
         /O3A==
X-Forwarded-Encrypted: i=1; AJvYcCUbfy8p6y1t+O1+aSZeRz/yompD2FRlVJTRiznW9+Ing7WNZu/mlcMm7zMcV7xDuzjvQvGFH79UrBEVqtxd@vger.kernel.org, AJvYcCV/lhjtWfWfddNu/bKGAssNLLzaZkK4PdsgZ8K+GfR4s14WswqKoKo/SVK4hSlEwjms1rNiV2gGsK+/wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOz69ba9wTWzlY9n5EwXkReRF/I/Gsf8GW4vhVzp81iKEuOilK
	EoG4NOQ8XF+iMYUpKjiNxWevDr7PFDLp1sCRw0Szh8v9tbAOBWtesdCET9tnnnmjbpC5IjkK/w6
	HmnbvcdcOSF+xvwSm8YRw+psjHEg=
X-Gm-Gg: ASbGncuBn/7qdD5nt2tNxVqXYQQbuocp4WoSwTt0mb5oIFgP6WFz+DAKbDsHBgc6fCP
	5uczuG1GC/WFEkFPSZYpncfc+AdJ2ynKLHtnmmTupFmwzWPpQvNsi7UNFYY9+ClK5npSEdj72VN
	GXancLqxMBtEQ8sEr9MG19kc8v+vuTA561i2JdbjiaoA==
X-Google-Smtp-Source: AGHT+IHWYEQ6LscglzBgawkGRiqBX2sOTVaS0nueKi1A4ZzRN9eK4g2H4WB1UETzJEMeMek/KVtF2JUfl6jDtMtPy88=
X-Received: by 2002:a05:6214:76c:b0:6e8:fa7a:14ab with SMTP id
 6a1803df08f44-6e9005b6618mr58352686d6.6.1741389280497; Fri, 07 Mar 2025
 15:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
In-Reply-To: <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 7 Mar 2025 15:14:29 -0800
X-Gm-Features: AQ5f1Jo_UNIHhJUaEMGqM4jtD6PWvuZ_dX8aqKe0wEkynddQGZ-ujq2FDrA5W-U
Message-ID: <CAKEwX=MtzM4Vw221pHTj8CZJ1NhLgo7Ls3xroxLRO399fzG98Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: Barry Song <21cnbao@gmail.com>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Jens Axboe <axboe@kernel.dk>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kairui Song <kasong@tencent.com>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:13=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
>
> Agree. A shared solution would be much appreciated. We can keep the
> kcompressd idea, but have it accept IO work from multiple sources
> (zram, zswap, whatever) through a shared API.

by IO I meant compress work (should be double quoted "IO"). But you
get the idea :)
