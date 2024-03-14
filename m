Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DB6F060
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418473; cv=none; b=b3RRN2ADtS4BWOHUiPRDoLhi53MaMCWaFQMjdUTVoAWmGjFrh07qb1xjuZIsk3VUYOR3jwHxaIpeHa3FlHkLzpdtgn0gh9dBFqc0dlb9GFdjM45ZZA1vfytuDTTAts1YQlMVmLUrEylJxvdC4kwyx1laDJ60LKHGFVQXSsI5prs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418473; c=relaxed/simple;
	bh=dYc6f0exUqcPfUdHJH+EyAtgZLzfz/x37SqOqu03g6E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fz9xwytb+rjsqOlGXgdfBIpQh+tmjjVWOx0xs5oDYphgWZ0xT2nM++z82FZhavFrPwFe5izsiKlLbOyPTyqa7NH1ZIkKzcqvaciNii8zxIhN5DQ5fL5ihmh96orNlM6MVgp79J9fhyHMlTfkI5jWBezotLpVTT/OR9/ZuI52Ui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZIn9zRY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZIn9zRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710418470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlOOg1k7Te+LxzN88lGdQ/vUh9O6lwZLPkMDl/ywJH0=;
	b=QZIn9zRYWYTWqX6Hz4s7qGkcrO7tek16VeHGFFdsMPjxcwUMh2AHYBw8QIPO/83P6ztNCo
	cXiOG0CvMsOzYVr3D+JYBqg9edaZRaiWvV1/TNcQ6oSkV+J8ShHiqud05Glevhd6EgfpA0
	+wuaU63J2dqKqmAdOqJa6v5pc8MUzhg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-1HXjuefLNeuDq3v4frOEzg-1; Thu, 14 Mar 2024 08:14:29 -0400
X-MC-Unique: 1HXjuefLNeuDq3v4frOEzg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29c74083a99so365812a91.0
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 05:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710418468; x=1711023268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlOOg1k7Te+LxzN88lGdQ/vUh9O6lwZLPkMDl/ywJH0=;
        b=BKEW59iqevx2iO9RL5c0OiGJm0rqbI+t5U5f7IHTPG6YslH/fu9ePs4RGNFuYChVrK
         1Z1UOL2MrRu3WcwpH0ZO1GaG/6m1wdPnpMHQ8aTVJMV7zRN6EseCEWw4SQfrzNZ1g3ld
         Gq1XjuD8nXBSLczgI9ISHD99K1lESqJTnCbxNOEHn0toW7M/4w32JkAQYI5YDy08NfhA
         wnkqDoVdaVNlMkTSKqb5JHqGgSc/rvlCn+4vRTvg1sMJINYbLGhgiBcg5qb7XCxgTaeg
         kU7+NW6z8ConypDsZW0JTKPoxDdva3+E3L8e+ifb59lOPPBzo9N/n8hDXO3xjUZe7Rrh
         fzTA==
X-Forwarded-Encrypted: i=1; AJvYcCVnLJmw27OVZqoh70WRDdqKdzaeUolMX3MUp8peebApH+Uoazf7zPTeB5HahpO2WjfmzLoAzOfgMQPel4mcXCQcvjlmHDWC76kPFuM=
X-Gm-Message-State: AOJu0Yx3rLGJc72vQREHFIETE88cxe8qc22YetY1E816iRAeTyV/tx2v
	JGhSvm7RURhx3ukpF4Vw3Inv0cl5QThiNxZcZC+CzNPI8ZL4sl/HxESo1+6Z+39gx7Ss+sM8s4i
	2mYAoBtb1Hipn2lhP2xkuq+9ryPSoCUGPHsoWsg1fG13c1djjw0B2WTbNh/gP
X-Received: by 2002:a17:902:d501:b0:1dd:5a49:7a98 with SMTP id b1-20020a170902d50100b001dd5a497a98mr1640043plg.3.1710418468364;
        Thu, 14 Mar 2024 05:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu1lypda1SV+Aw1YsnOcyfZmjXmrL3YHG/ruzVs1Q49QJ8abqSFdoRXbnSQERHu40ZJxaIAw==
X-Received: by 2002:a17:902:d501:b0:1dd:5a49:7a98 with SMTP id b1-20020a170902d50100b001dd5a497a98mr1640004plg.3.1710418467916;
        Thu, 14 Mar 2024 05:14:27 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id lh6-20020a170903290600b001db40866e09sm1522844plb.260.2024.03.14.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:14:27 -0700 (PDT)
Message-ID: <c38358c418d4db11221093d7c38c080e4c2d737f.camel@redhat.com>
Subject: Re: [RFC PATCH 0/5] Rust block device driver API and null block
 driver
From: Philipp Stanner <pstanner@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>, Andreas Hindborg
 <nmi@metaspace.dk>,  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal
 <Damien.LeMoal@wdc.com>, Hannes Reinecke <hare@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Niklas Cassel
 <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew
 Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Yexuan Yang <1182282462@bupt.edu.cn>, Sergio =?ISO-8859-1?Q?Gonz=E1lez?=
 Collado <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
 <da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>
Date: Thu, 14 Mar 2024 13:14:05 +0100
In-Reply-To: <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
References: <20240313110515.70088-1-nmi@metaspace.dk>
	 <855a006d-5afc-4f70-90a9-ec94c0414d4f@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-13 at 11:02 -0700, Bart Van Assche wrote:
> On 3/13/24 04:05, Andreas Hindborg wrote:
> > This is the second version of the Rust block device driver API and
> > the Rust null
> > block driver. The context and motivation can be seen in cover
> > letter of the RFC
> > v1 [1]. If more context is required, a talk about this effort was
> > recorded at
> > LPC [2]. I hope to be able to discuss this series at LSF this year
> > [3].
>=20
> Memory safety may land in C++ in the near future (see also
> https://herbsutter.com/2024/03/). If memory-safe C++ or memory-safe C
> would be adopted in the kernel, it would allow writing memory-safe
> drivers without having to add complicated bindings between existing C
> code and new Rust code.

Correct, but it would also most likely allow to just arbitrarily ignore
the "modern, memory safe C" (or C++) and write it the old way.

Those discussions are, below the surface, frequently in truth about the
question: Can you (and do you want to) _force_ people?

The Kernel's C already has more memory safety than standardized C:
There's devres, and since last year there's the __cleanup attribute.
=E2=80=93 but the thing is, you can just ignore it and do it the old way.

Once you give people freedom (which is necessary frequently), you'll
get people who ignore "the right way to do it". You certainly get them
once thousands of people are participating in your project.
Actually, Rust in userspace has a similar problem: Your coprogrammers
can call unwrap(), just ignoring those neat Result types and blow up
your thread. So you have to review and reject that.

One of the stronger arguments behind the push for Rust is that the
language by design forces you to obey, because otherwise the compiler
will just reject building.


P.


>  Please do not take this as personal criticism -
> I appreciate the effort that has been spent on coming up with great
> Rust bindings for the Linux kernel block layer.
>=20
> Thanks,
>=20
> Bart.
>=20
>=20

