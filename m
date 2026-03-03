Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB6379ED1;
	Tue,  3 Mar 2026 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512093; cv=none; b=pSBDVrksxn04xC4j/I7kj8mQ3sSFcg0fDdkbFA5YUOKO7LXbDBMJEhUEfFNTxtAu+xrDBcFLVi0sMoWVLZXrIgma+M+toBthdkFC/chaxtehTMBY4Uuj3aU8tySrbJFVWzGcXRjWYJlYRweDxMGsXxwyUUTZntBBfvGzELwg/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512093; c=relaxed/simple;
	bh=F1u58kc2HKbh7sJsNByf2oUOzn/KUBrEpV26blvtw0o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DUGX80ukmCLtc5XlZCI4mdG/vNMk92ATNuLHuSBKKy5hYZx18wFrARLqBG1HIfkvivuMtGeKQ/Q37hXqUBqA3qB9ITaMKFXjyUB/YBrh9X4vzfpYJjqRlM73NpjNbX2budHrHSiyE2bOHej1R6VdnKdJSq6/ilcbMfSVEPVDRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HAOaB3OY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HAOaB3OY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BDCC116C6;
	Tue,  3 Mar 2026 04:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772512093;
	bh=F1u58kc2HKbh7sJsNByf2oUOzn/KUBrEpV26blvtw0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HAOaB3OY4SLyxJWrh5SRbiTKbgqhvEsg+nhSRIcgrRKEa6kSvtvVJgVwkNSM36pVN
	 zkAT/+U5OhkjKXqQMMqq4RJt6phOSBxZ6agjvCN1Y1vzGbhNxdf515VUYrnzWrG8vW
	 nGoocEuIBpTpb31/3TCiZUYLQlhuS93v7qxjViVM=
Date: Mon, 2 Mar 2026 20:28:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, Brian Geffon
 <bgeffon@google.com>
Subject: Re: [PATCH 1/5] zram: do not autocorrect bad recompression
 parameters
Message-Id: <20260302202812.06e4fd4156e5315f0b5f3fad@linux-foundation.org>
In-Reply-To: <bg7ivz7ajiuzdbpv3h6hbptxgmqk5fhwakw4rzk4sz3bczky5a@rde3y352n5ej>
References: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
	<20260228120516.e5323a704d4a26bda041dd4e@linux-foundation.org>
	<bg7ivz7ajiuzdbpv3h6hbptxgmqk5fhwakw4rzk4sz3bczky5a@rde3y352n5ej>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Mar 2026 11:59:45 +0900 Sergey Senozhatsky <senozhatsky@chromium.=
org> wrote:

> Sorry for the delay.
>=20
> On (26/02/28 12:05), Andrew Morton wrote:
> > On Fri, 27 Feb 2026 17:21:07 +0900 Sergey Senozhatsky <senozhatsky@chro=
mium.org> wrote:
> > >
> >=20
> > A nice [0/N] overview would be appropriate for a 5-patch series, please.
>=20
> Well... I couldn't come up with a nice overview, let me try.
>=20
>=20
> The series is based on internal discussions.  Minchan looked at
> recompression recently and pointed out a few things that he thought
> were confusing or unexpected/unintuitive, like the fact that zram
> would autocorrect bad recompression priority parameter, or some
> other assumptions that zram made.  I couldn't explain why it was
> like that, and just agreed that it was confusing.  The final patch
> in the series removes chained recompression, which also has some
> unexpected behavior, so I just decided to simplify the code and
> remove that feature.

OK, thanks, I did this:

From: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: zram: do not autocorrect bad recompression parameters
Date: Fri, 27 Feb 2026 17:21:07 +0900

Patch series "zram: various cleanups".

The series is based on internal discussions.  Minchan looked at
recompression recently and pointed out a few things that he thought
were confusing or unexpected/unintuitive, like the fact that zram
would autocorrect bad recompression priority parameter, or some
other assumptions that zram made.  I couldn't explain why it was
like that, and just agreed that it was confusing.  The final patch
in the series removes chained recompression, which also has some
unexpected behavior, so I just decided to simplify the code and
remove that feature.


This patch (of 5):

Do not silently autocorrect bad recompression priority parameter value and
just error out.

Link: https://lkml.kernel.org/r/bg7ivz7ajiuzdbpv3h6hbptxgmqk5fhwakw4rzk4sz3=
bczky5a@rde3y352n5ej
Link: https://lkml.kernel.org/r/8a5d53d19a8dbd51d7d81d153676895163e0735e.17=
72180459.git.senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Minchan Kim <minchan@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: "Christoph B=F6hmwalder" <christoph.boehmwalder@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ...
