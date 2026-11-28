Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795884599;
	b=aNUgCGoB902fRfEi/KPR6SQTLTSSyLdK/31iM7zgkIWGCwoDUYhrRthY7xjqxPuajF5s
	 ljDYqrAQDymbikNOPN2eSJvkH7vfZtiLY9D0MK4z27EAVF3swmo0yIfwLovBMBjvJJHXd
	 MmQ7xaGCNqluxOXAGfLhTocL8G9/g2KWhPTWmmQ0p3wJGSC1kehBsfsFdKmFBCMQ+gA59
	 boADgq3tBRm22T5a8DuSh0ruMS3uCb95LcK28sQRtHbIOQ7yDZEsP4vmfbktVMsC9dTsR
	 8fh6QBjxlBE+tG8p6RupTQKFFnkYPSdOEbmMiG9cjZ9zHGDKf5K817WRP16//kuarNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795884599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tfzx160I4Qxrpq5WggwMatJFKJTdXst16iaBdeTovds=;
	b=Utwtj0196+ZZpa9JGpIctK13B5/krdrVwad/+Y4kO+kWKahTQolhxiZCOzzsTD7lByFd
	 ckmh6M2fmea9eqShP3Mjk0v45qgv/hGCGM0akWS6TrxZxv/qehr2E5cfrWwEp8GixDAqZ
	 JK+SOXBs4QIhtHBn9PJAsNjaFoqz8rGK2ZoZRlO7nGDbLcbQSBE/aR179qtHRTXa5nEX9
	 +KJ+LPUBThq7f8oVmPXsxgTpmk6hJSYUegQnylauS5UrYq0BklZI/s2RfiHot2TlUx7IQ
	 z6urEPDVKbq+9a6aAixe36kCGqDOCls0FZ99l00IYy7f6dg+KVab/Edf8fXrgIWOB8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeCQjzFb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC542606A31C;
	Sat, 28 Nov 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeCQjzFb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F2A1F00893;
	Sat, 28 Nov 2026 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795884598;
	bh=tfzx160I4Qxrpq5WggwMatJFKJTdXst16iaBdeTovds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeCQjzFbTK+SZuvlyY9Lkz5lbpdqLGGzQ//DIAaJ7Ved/GfWuA30xuMMqKhDEtDNw
	 T0Gb4JzX4hHzIz2pKQLrXHpT3JkZmPeQDHet1sm2HRHasl67ibEZHx6dAO1EzrOIdv
	 gqB5R5xHcV2EoMIppheLEY3OEMYSRI9BFmiFqVsWTvlXHAU5UbKRN7pqY1tb55ahBq
	 1A48VHPyah0ZoPHy5Go/vzin+VUqEULPq4pmu8omCmuSZX+rkgyTJJKi5dqIlbh8Rd
	 Oh6xqHXjKl6VrPpRAp+yDsHWP4//Xo3ayVfeFKtFm4n6oKErE6SFidlVvOVeYmVo9y
	 XefRrSj/flfVA==
From: SJ Park <sj@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add mm and block lists to zram entry
Date: Sat, 28 Nov 2026 08:49:50 -0800
Message-ID: <20261128164951.92191-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <awozzzB7zkfAVBqE@google.com>
References: 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 28 Nov 2026 10:53:08 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (26/11/27 10:53), SJ Park wrote:
> > On Fri, 27 Nov 2026 12:16:38 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > 
> > > Route zram patches via linux-mm and linux-block lists,
> > > rather than through the generic linux-kernel.
> > > 
> > > While at it, fix a DRVIER typo.
> > > 
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> [.]
> 
> > >  
> > > -ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
> > > +ZRAM COMPRESSED RAM BLOCK DEVICE DRIVER
> > 
> > Thinking loud.  I was wondering what is changed here.  I found it is fixing the
> > typo: s/drvier/driver/.
> 
> It is mentioned in the commit message, the last sentence :)

You're right.  Thank you for correcting :)


Thanks,
SJ

[...]
