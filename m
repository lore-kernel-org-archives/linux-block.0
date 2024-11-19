Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F13FF1
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 02:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731984323; cv=none; b=SozUbRWfRBPdP/4kgcJZr9S2gr2GSS6wdQL4hiwXkjGxBKJu0LHsCnLNRPjbntIoZxp1JIzI6SNwF/DkL3CFcBXEPypFNvXZ0DqlDlZaImw4pgOQjS59w1SH95n8Ax+pk6ukLVYCzR2GDiLWHSs3csRy/RCtygP2gFqXZEfIOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731984323; c=relaxed/simple;
	bh=v+eVJ+X+lE5pavtEETKq0rPDaww2LKzy7AJD6iqlQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFLKAQDxsth7zSDCmqM0ax4xouVmzpComtqfRQn81XDZEC15jZJ4vHZlgPmdnvkyT2QBlm6jfVVjjapHU+At8vqAOLhvdWKsZsuhykkWf3j7cyuMOqbH4mbwJUBq95sv6uKwci45Trpq2d/uNoF8SKgcIWR/JbKRp3nt0cIWU9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HWS7zO51; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HWS7zO51"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5f835c024so293741b6e.2
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 18:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731984321; x=1732589121; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q2Wt2ES0hTCtyLcyTU1ZDNM/oZablsFyOW7XoxCb+2M=;
        b=HWS7zO51xjUWU5yAS+pJQ328mvzUaHKyDQUqwj6CmNwpcQC1Bso+UEISV7uK/YthdT
         4u123gqEv088NwBdXmBw9vQe+dMPSUoVDB8Ku6Nl5SSRUwwixJsUTsPW9/0jtWJiv+Yt
         DuOfeLqt2oFzIYZuljo3cQLw+4fLwTuWyiuNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731984321; x=1732589121;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2Wt2ES0hTCtyLcyTU1ZDNM/oZablsFyOW7XoxCb+2M=;
        b=VA/zciDZpI40SIzkA4jXtn5l/eEWtfunLQ5qIwxQdLzheZdmqCdzbY6q7UKL+yKY7v
         iFRdXIzLazTGbBBbrCHIbdSuabytO5t4gJNjGd/HBmfCtkiZHmnNTj2mnNLPbVIil2fN
         PkqVlmi7OLTt3iU+qY+RZUnj0O1Q9JDmQXvmW4KzRoyvbw9BCGTpw+JqY+x2lDhT2i/x
         AUqctEuPetszYWXQ6uZaJWpGNR9zhsRDVIWFp0NbhGnY2zp8MBCAinqPwIffZoo2pawI
         0ylq7Vnn2HowtPYjgxYgJdxClMJVZWzEdOHOc3HMUloStHTNyNJZINEWswM3auzYlXCE
         ue9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo5eNq4vJCGaN2wmU5uzEQ3AW6WYBfEPxYxk1MPJ178vtE1WRDjCRCCXpz7WzUgq8YgZY1GfzGfvjRfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7fizdzDJdGU+9NwOvEtAlqwqXPR6UwZ+sEsKe/OGU/JeVn7r
	hsZqc00bEym84hxUaC3Hw9n5ZTGfhSv90yjruJjFWWFHYuJFBjX51oTAZZj0BA==
X-Google-Smtp-Source: AGHT+IEWl24B1WpdPKp4Clv2rvVCSLNfIHe4/VIJNYlEWb7RLoJX4/gAsejqgIC54PJU1p0Fm0mRRw==
X-Received: by 2002:a05:6808:1996:b0:3e6:19a9:4718 with SMTP id 5614622812f47-3e7bc87ed5emr12548188b6e.40.1731984321380;
        Mon, 18 Nov 2024 18:45:21 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8826:78b8:a8fe:1066])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c64f26sm6531771a12.48.2024.11.18.18.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 18:45:20 -0800 (PST)
Date: Tue, 19 Nov 2024 11:45:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Barry Song <21cnbao@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Usama Arif <usamaarif642@gmail.com>,
	"Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, axboe@kernel.dk,
	bala.seshasayee@linux.intel.com, chrisl@kernel.org,
	david@redhat.com, hannes@cmpxchg.org, kanchana.p.sridhar@intel.com,
	kasong@tencent.com, linux-block@vger.kernel.org, minchan@kernel.org,
	nphamcs@gmail.com, surenb@google.com, terrelln@fb.com,
	v-songbaohua@oppo.com, wajdi.k.feghali@intel.com,
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com,
	zhengtangquan@oppo.com, zhouchengming@bytedance.com,
	ryan.roberts@arm.com
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and
 zram based on multi-pages
Message-ID: <20241119024513.GB2668855@google.com>
References: <20241107101005.69121-1-21cnbao@gmail.com>
 <87iksy5mkh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wOGPbGQgqDidnYUCCpAT8sw+S92NEU+trAQL_rnC10ZA@mail.gmail.com>
 <28446805-f533-44fe-988a-71dcbdb379ab@gmail.com>
 <CAGsJ_4yuZLOE0_yMOZj=KkRTyTotHw4g5g-t91W=MvS5zA4rYw@mail.gmail.com>
 <20241118095636.GA2668855@google.com>
 <CAGsJ_4xmVm3QmfQoUe20OouiYQoer5CGnAiz-ppvum1esNmeDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xmVm3QmfQoUe20OouiYQoer5CGnAiz-ppvum1esNmeDw@mail.gmail.com>

On (24/11/19 09:27), Barry Song wrote:
> On Mon, Nov 18, 2024 at 10:56 PM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (24/11/12 09:31), Barry Song wrote:
> > [..]
> Yes, some filesystems also support mTHP. A simple grep
> command can list them all:
> 
> fs % git grep mapping_set_large_folios
> afs/inode.c:            mapping_set_large_folios(inode->i_mapping);
> afs/inode.c:            mapping_set_large_folios(inode->i_mapping);
> bcachefs/fs.c:  mapping_set_large_folios(inode->v.i_mapping);
> erofs/inode.c:  mapping_set_large_folios(inode->i_mapping);
> nfs/inode.c:                    mapping_set_large_folios(inode->i_mapping);
> smb/client/inode.c:             mapping_set_large_folios(inode->i_mapping);
> zonefs/super.c: mapping_set_large_folios(inode->i_mapping);

Yeah, those are mostly not on-disk file systems, or not filesystems
that people use en-mass for r/w I/O workloads (e.g. vfat, ext4, etc.)
