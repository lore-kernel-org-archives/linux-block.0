Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB827B35C;
	Fri, 12 Sep 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669008; cv=none; b=t2lo1So//SdoQEOQ02rLJnFgMfBwNYklVJbxN80dsuMr4Jx76H2qgS5ztqsynju/UjcBdlTA5HcvOg7CyoQ/DSQkcc5wI6CFrKBKNs3gIHVFza435ECOCS2dTU3/4gXrPVeaZc9apCDABE8vmiKHd8oVh0h/WjT37DunERDV4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669008; c=relaxed/simple;
	bh=C41iYMKm4+K4EFYPba7bEsrP/ut3g2gBXRLTNMIh0I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgZvFaECKk3gVb+GI0NE6vIy2Zg4OLHsuZH/hWbpiZSFFcCl3ekrSsqWZ2DfTL8fu+W5z1jRg2N9E2uwRDZQLsX4qtwfS4C3dbzmUus8rsNbUyGbtJCgMMIbq1LiPv31vBt7rkwzRku55muC3bK7A746t/dkkfujYSG5hfFvRcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9EnDURd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9EnDURd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189FEC4CEF1;
	Fri, 12 Sep 2025 09:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757669007;
	bh=C41iYMKm4+K4EFYPba7bEsrP/ut3g2gBXRLTNMIh0I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9EnDURdVKe3ZIPAxFRgqiKn5VY9IjvNjJ6km+9IJDaM534N9BrLJTsLpNn5/fsES
	 4Ik7r8FxqvxuNPsAGq4KflI7Pov0/6GspoWzfwLxqTWN2s4lRP/r51j+MSc0bUiqeL
	 bsdNPyjz9O7EJT5rxqP6ul+8r8gSVNrqJaND/aa05MjsIaS3BRZRqIUqUR5CuUBSE4
	 j2YuNzv1IlfFvgSSXhp4s9EJtzKiP0dZh2U+OfNqT6/NXVLDMzSV3CxogjxvaoTy76
	 zjJjLNweCmtWGiG3Yh9UKpX3vQckrrRXEAjdGjg7dOb8oU03/dywCsvuf60eJ7xvBQ
	 NguucfbJTfStw==
Date: Fri, 12 Sep 2025 10:23:22 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <20250912092322.GZ30363@horms.kernel.org>
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
 <20250909151851.GB1460@redhat.com>
 <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>

On Tue, Sep 09, 2025 at 08:33:27AM -0700, Eric Dumazet wrote:
> On Tue, Sep 9, 2025 at 8:19 AM Richard W.M. Jones <rjones@redhat.com> wrote:
> > On Tue, Sep 09, 2025 at 07:47:09AM -0700, Eric Dumazet wrote:
> > > On Tue, Sep 9, 2025 at 7:37 AM Jens Axboe <axboe@kernel.dk> wrote:
> > > > On 9/9/25 8:35 AM, Eric Dumazet wrote:
> > > > > On Tue, Sep 9, 2025 at 7:04 AM Eric Dumazet <edumazet@google.com> wrote:
> > > > >> On Tue, Sep 9, 2025 at 6:32 AM Richard W.M. Jones <rjones@redhat.com> wrote:
> > > > >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:

...

> > From the outside it seems really odd to hard code a list of "good"
> > socket types into each kernel client that can open a socket.  Normally
> > if you wanted to restrict socket types wouldn't you do that through
> > something more flexible like nftables?
> 
> nftables is user policy.
> 
> We need a kernel that will not crash, even if nftables is not
> compiled/loaded/used .

Hi Rich, Eric, all,

FWIIW, I think that the kernel maintaining a list of acceptable and
known to work socket types is a reasonable measure. It reduces the
surface where problems can arise - a surface that has real bugs.
And can be expanded as necessary.

For sure it is not perfect. There is a risk of entering wack-a-mole
territory. And a more flexible mechanism may be nice.

But, OTOH, we may be speculating about a problem that doesn't exist.
If, very occasionally, a new socket type comes along and has to be used.
Or perhaps more likely, there is a follow-up to this change for some
cases it missed (i.e. the topic of this thread). And if that is very
occasional. Is there really a problem?

The answer is of course subjective. But I lean towards no.

...
