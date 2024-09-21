Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3724A29
	for <linux-block@vger.kernel.org>; Sat, 21 Sep 2024 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726877104; cv=none; b=rE7PCEC+MDFst1OP6BvGLCc6/Yh0bKS7ySMgBCpzURH16tXgu1c9FGXmqjUDMdwA9uToipOR46hHFi4Tg05OktbbCWAwcPiUMRwWMswWYhYfTj3PH5If8wmtqmYJnMIClyX+0kJkmSoWAWZwt7fOCrlSUQXB2xJIOl1/HJutmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726877104; c=relaxed/simple;
	bh=INlKS5tNGyAIUwftuVV4YHTl+jDewLLG5i9G1VOSdhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGjb1Cil851aZ9M9rqYaCY8VZwX4uWTY2uqC3GhukEteYx53hOg4HDn/MLc16bX+XA52BRfunKPHImKQcHc9EPm0QJuMYH17p2mpK4gZaKTub7xO5j0geLjVOB2KTuUE7Rc2ligHSTI/OR024pITSJ9LnYxqA1UHQHc6NSv/87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e64ROaQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e64ROaQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C75CC4CED1
	for <linux-block@vger.kernel.org>; Sat, 21 Sep 2024 00:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726877103;
	bh=INlKS5tNGyAIUwftuVV4YHTl+jDewLLG5i9G1VOSdhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e64ROaQJhUMqElYUQvXISerGDpIgaACDwT1Pmtd/JcGFjg7r6G4Wcol9dW/Ct5Yh8
	 TEfFcHACIhE5bljDlNWosYLpPaibQbHrXBbIjuTmyIYJibl+e4+Zcyuf8t08CUdNKk
	 rci2pYV75wXebjmxuOXOGCHDp5+jebj9tZtIcqFg4o0Qpsu7JhTyZWtXFhHjOi6bmr
	 7e4XdUqRzIm6u2bizoq96GkLNRuFTIj0C3bHZQO4CnLE8HF+luv1sWPFzRSNJB9nqP
	 qY9vo7jEunq2b3e08He+0raaz+TwkV9/adhZDMS39wOg0bnGqTURW8tMAnGmD+X9br
	 y0Q769Iw6u3pA==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e1a80979028so2651662276.1
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2024 17:05:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSpfNvqR66BnlA4lnITC3zmfGMM4vQXkSzCUzzkyK7EaldTgsNaEUpCtXbIwEE+9bliDGwsWmXYXCYbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpSdoySLumBq8wVJDCPD5SPI6tn/XXXAV/Loi7wUGO+NhmJAO
	k88xR26WMNHLCIl0MYCaSK5XAS+MLxhKRH2tbrOZsKF3ht5UNAlfpz5D2YQ0ZAHD+Lh/i33qhV2
	VyXJvugSQhnkOghq+yCYresJTOi0TMK1LbCSzSw==
X-Google-Smtp-Source: AGHT+IFTgD18lT/k5y3/uFsZmumRkstI4L4Woj+Ow1MTZJ00Q7iFIujz/YsqJe0xXL7E4JJ1Hut1lEDJr9Sp5F5cVxQ=
X-Received: by 2002:a05:690c:6506:b0:6dd:bc2b:2aa4 with SMTP id
 00721157ae682-6dfeeff826dmr53781547b3.39.1726877101859; Fri, 20 Sep 2024
 17:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919112952.981-1-qun-wei.lin@mediatek.com> <ZuwM-aEEo7DE-qXw@infradead.org>
In-Reply-To: <ZuwM-aEEo7DE-qXw@infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 20 Sep 2024 17:04:51 -0700
X-Gmail-Original-Message-ID: <CACePvbUCNxy3sf6+7hk9HPGTNtTMbA2=Entu0xbV7TbwX4M2WQ@mail.gmail.com>
Message-ID: <CACePvbUCNxy3sf6+7hk9HPGTNtTMbA2=Entu0xbV7TbwX4M2WQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add BLK_FEAT_READ_SYNCHRONOUS and SWP_READ_SYNCHRONOUS_IO
To: Christoph Hellwig <hch@infradead.org>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	David Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-block@vger.kernel.org, Casper Li <casper.li@mediatek.com>, 
	Chinwen Chang <chinwen.chang@mediatek.com>, Andrew Yang <andrew.yang@mediatek.com>, 
	John Hsu <john.hsu@mediatek.com>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qun-Wei,

Agree with Christoph that BLK_FEAT_READ_SYNCHRONOUS is not set
anywhere. That needs to be fixed.

Having a flag for BLK_FEAT_READ_SYNCHRONOUS and another flag for
BLK_FEAT_SYNCHRONOUS is just confusing.
for example, read path need to test two bits: "sis->flags &
(SWP_SYNCHRONOUS_IO | SWP_READ_SYNCHRONOUS_IO)"

There is only one caller of the bdev_synchronous(), which is in swapfile.c.

I suggest if you have  BLK_FEAT_READ_SYNCHRONOUS, you should have a
BLK_FEAT_WRITE_SYNCHRONOUS for writing.
The previous path that test the SWP_SYNCHRONOUS_IO should convert into
one of tests of SWP_READ_SYNCHRONOUS_IO or  SWP_WRITE_SYNCHRONOUS_IO
depend on the read or write path (never both).

"sis->flags & (SWP_SYNCHRONOUS_IO | SWP_READ_SYNCHRONOUS_IO)" will
change into "sis->flags & SWP_READ_SYNCHRONOUS_IO"

Then you can have  bdev_synchronous() just return the
SWP_READ_SYNCHRONOUS_IO | SWP_WRITE_SYNCHRONOUS_IO if both are set.
You don't need to have just bdev_synchronous() and
bdev_read_synchronous(). That is more boilerplate code which is
unnecessary.

I also suggest you squish your two patches into one because there is
no user of bdev_read_synchronous() in the first patch.
You should introduce the function with the code that uses it. Yes,
yes, I know you want to have a seperate patch for define vs another
patch for using it. In this case there is no good reason for that.

Best regards,

Chris


On Thu, Sep 19, 2024 at 4:37=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> Well, you're not actually setting your new flags anywhere, which -
> as you might know - is an reson for an insta-NAK.
>
