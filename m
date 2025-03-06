Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393A376;
	Thu,  6 Mar 2025 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222015; cv=none; b=JoQim9XjGk8Yb2uS487SmZrAhXGuuDv+6SlRQ58P4WgAJaQ2ygPk1luKkLYPEnimBotkOBIhBl+Fl79oHfyPrKLWxppJVQFlppj1P07cw1u859xJAtdQ+f5KzhMyt5+DnF/CJ9VrJTS6ZvCau5qbAQtIsitTWIhHXAJg2ZmSRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222015; c=relaxed/simple;
	bh=I9Gwb+4dTz3fcNf1F6yu4Sjs1ZiacNO3dNVCwPrvIZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPlrp0O7H6WY+ySft508BkemSs8U7H1+F41UKp/ZupR9WK76bDPFYVpZm5m++PBUWEQa/LFl7hyqoqyQ2pMnUzO6V0dvKaVdgubSj7LoCVnZt826LN4qfTVelp4BwiWu+ivYgHIFe945pLD47zf+1J02k2j1Ks5n2+pKZcd0n4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k18Kwvma; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k18Kwvma"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22334203781so27658355ad.0;
        Wed, 05 Mar 2025 16:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222013; x=1741826813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+35VwW0guPAXPD3vm8P/KmL9oBW5pOr3grFjFyiZYJM=;
        b=k18KwvmaGcP2M+PGYW2AkhEA1T1Oz2oml3Uz5WjIv0QOFLbnUNYp5psLjvKFSNVIhZ
         QH4KOWTXMHV0MZeVg+ZHTYCR7KccwOwY54rNe29xmpvMk23o4jlfQ+XF/7GUnAjtLMC9
         Mwyj+AEquiFbgIp2Tz/bF6MjqbmDJbTaZn1/3kJTSxFIvwVl5lrlwEu1F4nwvDrpeVp5
         U/Nz9puyi8iCgbKleq5TRsxK5AFKqnyrkzFIIP9cbhwFq9HKs53fno6rxYvEWDDYtqIc
         IcPtsfvvJetkcKO/exGAaRGqMbNzHzq1iUDSCd4YSnjZSf+vHof7mEkexIzVY/cyANQi
         Njyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222013; x=1741826813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+35VwW0guPAXPD3vm8P/KmL9oBW5pOr3grFjFyiZYJM=;
        b=oHDpPqJwx7ryRyfT08TNnNzoFvgBdhopO2tEHALD9Ba99VZmyOq+vR0gX0z1gKhVPo
         NFjeVFcax9nt0QJu88smuDvkKievPNYUDDlTy1s02VVx7OLRVv/LV5Xjk+oAglz7Wf58
         Zf5Z9er5NI6WwCSeKXWXz/aivVg74ujLKW/Bw9EU2JLNIWdaLn8qu7Uys2N9ofFu55U5
         0m4zz9T3CNQ6M8PBvIUEGghNAa/55jTPAh/S2nMj6esx++HVDXi8tSYt2fAlRwNXVAiC
         ZX3uuNPc9k1Mvq4kQOdVEfbtssb+2++hra2bBqL1AzbbCObEYFCdK8+SsN1N9uJYmmlJ
         vlRg==
X-Forwarded-Encrypted: i=1; AJvYcCW9mePlR1f5QIm9zQqo5yieI4zZSsfg64ux+hqScHMp4LIvkXCXyuwz4SiEhdf425ClkxZk+HEiFXRKoQ==@vger.kernel.org, AJvYcCWtJd2ZGB+nHx+cbV0T/BPq/vF2r+2hWwKP1OGavay1nOyTPnUMMSeKAyw7vDiMo+28ti5XGc1Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24hKIHOnuU7g9HD9ySLpGC6UXtn575c721o1max+scVbeFNvU
	TAszBYioKM2HwM0PAPs4TqYnP/apMe6iHgJtGA/bYQn4hCOMwF34
X-Gm-Gg: ASbGncsyf5mdgx2aPNQTYT277+0R32pIOZm96+iOruC/ad15sFyPC4sGjfoPTyCXEnp
	vsTwoBObT6eM2VRpH7zpGDrxdphe7tB1roFaf1h8I2YQyC25xXdcJlD7i6yfUp60+oEJ8CvYrtM
	jqntmJIRVhiAk+nwTRCK5UxtlGEfEZZr4diHHTbOsBYeJJGN1PFVxisMH1kvYmPdxjnbEzj77T4
	Q7jWZp2kft5fB1WEywlYaNA17yG1inNUmA6Wcp4tH9Ij255SKnHWNAHQ0zRXbK6DFc47+IoA4vb
	Px5y6RZhze/4mpImEE3op7mGDb2aQnUsqAK9w2+IGhoTrSRl
X-Google-Smtp-Source: AGHT+IF7vCbcPdVKVzzzP+Jt9zGpX61vizMrmay+ZL8kmmG60vfaBPu0w+ySA1n4Rl5PNTclnwnm5g==
X-Received: by 2002:a05:6a21:3983:b0:1f3:3864:bbe0 with SMTP id adf61e73a8af0-1f359b18686mr2000333637.8.1741222012978;
        Wed, 05 Mar 2025 16:46:52 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c1d24sm70649a12.41.2025.03.05.16.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:46:52 -0800 (PST)
Date: Wed, 5 Mar 2025 16:46:51 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Hannes Reinecke <hare@suse.com>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Networking people smell funny and make poor life choices
Message-ID: <Z8jwe7dFXVEI9fT1@pop-os.localdomain>
References: <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
 <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
 <7439cb2f-6a97-494b-aa10-e9bebb218b58@suse.de>
 <Z8iTzPRieLB7Ee-9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8iTzPRieLB7Ee-9@casper.infradead.org>

On Wed, Mar 05, 2025 at 06:11:24PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 05, 2025 at 12:43:02PM +0100, Hannes Reinecke wrote:
> > Oh, sure. But what annoys me: why do we have to care?
> > 
> > When doing I/O _all_ data is stuffed into bvecs via
> > bio_add_page(), and after that information about the
> > origin is lost; any iteration on the bio will be a bvec
> > iteration.
> > Previously we could just do a bvec iteration, get a reference
> > for each page, and start processing.
> > Now suddenly the caller has to check if it's a slab page and don't
> > get a reference for that. Not only that, he also has to remember
> > to _not_ drop the reference when he's done.
> > And, of course, tracing get_page() and the corresponding put_page()
> > calls through all the layers.
> 
> Networking needs to follow block's lead and STOP GETTING REFCOUNTS ON
> PAGES.  That will speed up networking (eliminates two atomic operations per
> page).  And of course, it will eliminate this hack in the MM.  I think
> we do need to put this hack into the MM for now, but it needs to go away
> again as quickly as possible.
> 
> What worries me is that nobody in networking has replied to this thread
> yet.  Do they not care?  Let's see if a subject line change will help
> with that.

Since it triggered a kernel crash, I am pretty sure people care. How
about sending out a patch to get more attentions?

I am not sure what patterns here you are suggesting to change w.r.t page
refcount, but at least using AI copilot or whatever automation tool should
be very handy.

Thanks.
