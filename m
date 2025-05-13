Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38965D529;
	Tue, 13 May 2025 03:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747107686; cv=none; b=XwUB9eoD2lxPaIjFs2m89AhTUCOHS4Mr5jLFviiENc2KKKJNGlVFX1tugopBQsfKu2E0a2XzwQXCCkXBFQeJkjEwT8+gPROiQG1aE3ugjsdyNfkww/IK5r8yngn1/24GIc1+fZCP1WwCm9PYha2rzDXvOPaRTc9uso3WNSz9z7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747107686; c=relaxed/simple;
	bh=NFSeFScoE95mFnj+yxi0bvHG8cpAv1t9f/HO6+9GAaM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EVXWvzraW0GmlyhlZ7sFRnqP/JQZVpMcBvPOAIy6Y4l4DULuJ0PAuvqYaYO28pdesunkp8ZylFXFMEgF6i1F7Qr40I4N/vOvZxlfdxV+BZHBMD2qsLjsCsExuzI84+EV//2Ve23CU/OWS7MpBJVNy7fN/betgTQORavCTgltW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1Iwf6CL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1Iwf6CL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E96DC4CEE4;
	Tue, 13 May 2025 03:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747107685;
	bh=NFSeFScoE95mFnj+yxi0bvHG8cpAv1t9f/HO6+9GAaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1Iwf6CL7Iz477IytgTrTWW5oDMGdDER9PK2ushheMAVDJslIDykeofH/ycB2gymuN
	 XKWXWHTf/64AfZTwg5xPd8rhxF5rVYoM1jEMnby8cemmYGOfOPH40ChYucllLNI8tA
	 ZauxfyFlPsuwXdDsQTTOj9+apS04yYrlGBdgZUcs=
Date: Mon, 12 May 2025 20:41:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics
 function
Message-Id: <20250512204124.5f201b7bcc394f773f2d40b9@linux-foundation.org>
In-Reply-To: <CAL+tcoD+VrRfAGMjj=9uAbanMO=W+cW0xgxMzVwrpiTgagmQ2w@mail.gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-3-kerneljasonxing@gmail.com>
	<20250512175156.7d3d4db53d40c7a34c1f68d6@linux-foundation.org>
	<CAL+tcoDk2TFwAWPwBN+dQQ+guxe71F_R1rFX_f9wozjPpujBAQ@mail.gmail.com>
	<20250512190427.b7fb67f6b78fd8699ea2811d@linux-foundation.org>
	<CAL+tcoD+VrRfAGMjj=9uAbanMO=W+cW0xgxMzVwrpiTgagmQ2w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 10:26:45 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> >
> > Maybe we don't need to check !chan either.  Can it be NULL here?
> 
> It depends on how users call this. If users call this without
> initialization of chan, relay_dump() can avoid the crash. It works
> like kfree() which prevents the NULL object from being freed.

hm, OK.  Generally, I don't think that kernel code should be very
tolerant of bugs in the caller.  If the caller passes us bad stuff then
that's the caller's fault and the caller should be fixed.  If the
client code responds to bad input with a nice solid oops, then great! 
The caller will get fixed.

> BTW, should I merge this commit [1] into the series in V2 so that you
> can easily review?
> 
> [1]: https://lore.kernel.org/all/20250507134225.63248-1-kerneljasonxing@gmail.com/

That seems unrelated to this work so it seems inappropriate to combine
the two.

I skipped [1] because I'm waiting for overall clarity on what's
happening with relay[fs].

