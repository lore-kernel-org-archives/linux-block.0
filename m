Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48A1F3D56
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068201; cv=none; b=QfV7eYPqJY0KzNqROAO8IPoyhSkZVFaOdVKR7ZvaFuF4IQGnK68BF+JTebpLeesL43ISyGmtOP9Vb83cMQWnQw7ZtEJkO/soTZJ8MtCl73xjo9/D8dUydR6vuCK8ysQkGj5mSS6a014zyUO4LOE7tdmpL/ER5u8lSUISAHQf/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068201; c=relaxed/simple;
	bh=ccqhZ6D/BBFVT/2vphyPtM9hsxZ3BdFQnc0Ne90kRXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=les1EGkk93huQuONwS1WzNLPco5CbMX5KNd0mUSN5cRv3BgQkIJITH+i69WNegQQ6WvsVqQ+Sb9/ygoFTqAQE+MXWLeQtS7ACnT/HufcQ1KfDqvJnKmXOCcB9JxWcIhbVZYP2Ju7LnHaLG0Ah/2oGJ5qlFXzXmw807sSIK58jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V9k4ZDt8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V9k4ZDt8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31393526d0dso2661269a91.0
        for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 20:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753068199; x=1753672999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQYfFfM/mtR1CICbJUBbGQ90ReaVEsvi5HRRAnkzelk=;
        b=V9k4ZDt8uy4e321aKMRrX2kTOqpGhUnbCINVuehoqB3B+QcudnSgdJZRnbd1r4cEiw
         V9f6mRphNV1M7927W8ojbuKPQGUgha51cMS4NqJaJ31idC10waaRP/SDUS/oaG1478fe
         +qNRVYURsql0MWgCgStpj5/kDKJiTOIQvJo4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753068199; x=1753672999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQYfFfM/mtR1CICbJUBbGQ90ReaVEsvi5HRRAnkzelk=;
        b=YLHDfO3mvpgAgCD9WUs9DExXWQO6giHLIJmBB8+zP2Qxlq6+1CH4Bbh5EfKtvP9ZiR
         ZOMpHXoSya3JyuJgcjGjLXRO62xVjh/vdmseR0doPSZlOtYUcguhZZAqp7Y9NvevJOmi
         bwI92WZu8NK0OfE73T5pI8YPPp4uECtlnffhCYKwvJ6hFqnBVsjX2h141ry/PqSYqSkl
         vYDjQBhyyaCZjh2wFWoY7QLRUh7DDxOPC4+jnTxdW19ypxlli0riex4+Br2UEPCEEOPo
         rC0EHYmrkRorJuthmkOa9uP1cbIRtzPiOr5Yd86BhZXb1T8hx8PdOo6wus6ekkT02dAr
         lyJw==
X-Forwarded-Encrypted: i=1; AJvYcCVR7uNbUbH9NTFQgxOigfLoJ+PXwBoHR4jgxZbtWiYj/hx8iaY4VDCXE5RtiUYqNmLTd7iQxOl3kQ5KkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkn09YdA2oSb4uoAe1ApAwrWAvujnZaJYvLNrVKoG1gG2rSqhZ
	ScV1/Hwa3tKj5OatPK6vbwwVxUEGNQIwpPFaRX0esrVuZC1pOySbnccMD9duE8ikVw==
X-Gm-Gg: ASbGnctKZBbFKlHo/y+WhZ2OrfSH8cKurbOITo22GdwIz2oqvLl+rqMkdnwY6Ix0NbR
	O2YzEvVU9A+iiB69okz9JXAQMtTJjhl63MEgF2A+ljcAC/enlH2x4uPaB3EdmgTEtzSF0K0Kz+X
	+Y5Q92PjeXtm70811D3rIGYSOFI8dYQqOcRIQ8oQhiaHWqLtCjEW6VXeMlDqi9fYIRSfMwGvILX
	C216ZkgiEB3QrIg+Vl/ViEK01it/SjqBURoa/V9p/6Hq3MAHH7iCC79pr2l3HJ7ASOp0Rr2e5g4
	fHt6wWRCNz8d/hzv0Fcsdr5qxqBzNbKkwZbLua/PWXkVdjspwB3spKT1Njt1N3vem2m+fmHaxJQ
	JwnvRSDwDIQTB4rnTAdeu5BkC1zf7/OsYdKNH
X-Google-Smtp-Source: AGHT+IGMOr/h4t/0+dcYhb0THiLSuS0RfTOtcYQsA0CBLh3fChq1lYhkQ68N31p/ZeB4Swgqevsz+w==
X-Received: by 2002:a17:90b:2d4d:b0:311:c1ec:7cfd with SMTP id 98e67ed59e1d1-31cc25e7a85mr16061926a91.26.1753068199361;
        Sun, 20 Jul 2025 20:23:19 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ca29:2ade:bb46:a1fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e4571asm5092945a91.6.2025.07.20.20.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 20:23:18 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:23:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <r7mtqczhwcyt7xwpmvn5k7iwevta46z7xsu7t2y2xxnwlv7byc@ksiuu4zlllod>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
 <z64pki236n2mertom6jmgznj4t3dkxeosr56fhpmykjdrnzs2l@5xlhh7htcaw4>
 <aHzZSKqAJR9Wk7SX@equinox>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHzZSKqAJR9Wk7SX@equinox>

On (25/07/20 12:55), Phillip Potter wrote:
> > I don't have a CD/DVD drive to test this, but from what I can tell
> > the patch looks good to me.  Thanks for taking a look!
> 
> Hi Sergey,
> 
> Just to say, I haven't forgotten this :-) Have run a few tests with the
> patch and so far looks all good.

Hi Phillip,
Thanks for the update!

> Still been unable to replicate the specific issue though.

Hmm that's interesting.  I thought that unplugging a USB cdrom
drive would hit the issue relatively reliably.

> Assuming my testing uncovers nothing else, I will
> revert to Jens with fully crafted patch submission in next day or two.

Sounds like a plan.  Once we have an upstream patch we can cherry-pick
it and roll it out to our LTS kernels (and eventually to our users.)
