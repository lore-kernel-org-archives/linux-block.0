Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7853C3C;
	Sun,  6 Oct 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174152; cv=none; b=POCEKr6WkWPztwPl7Zc0rh0l+8MjwuOZMgPRLW16ukKUxYmzB0agd7jld1M4cZlUzj8gspufOeJ+Dm+5Dy8SU6VpWlk0VquU99RFLfGldZNkgbmP/VrjB5lJ+0Kv0K93DbxAEEwxvPFb7rzbwTC1RNvTq4DAHp5GUQgG1PebnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174152; c=relaxed/simple;
	bh=o0ez3cEN8lo6BNqb/QRS8T3RA9GefH1zDvKe1gnASr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Fy3SfksjrJjvxMcCbbkZR1wU+WtfvaOmGv940dyan+qSe7yhgq/b7NI04BTeeKZvscMnBdny2jOS9/spQyFy72o7VXb7mnEFOhjGO/iHAcyEORoAcrXvAVN1xsrmD6J+0ZC6zlYx+ymFjKkVtqZ9LX/DioWM0JG+9pNQV77kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhjPqz6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhjPqz6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C0EC4CEC2;
	Sun,  6 Oct 2024 00:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174152;
	bh=o0ez3cEN8lo6BNqb/QRS8T3RA9GefH1zDvKe1gnASr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhjPqz6O3kPZvQ5ohWx0v4V5gFe1jrD08I/5mw4r08GpMNEDHsJ8vCwE+57rHWgAA
	 iATIn7z0R3ZcFCEvNz79PGb9kKoa5ZU6tdYEGRBO3ND+LoYt+4A1bn+be+fxU3u1zG
	 txrFI3sk6yXVYQ3sbjg856iBTO0MDLnuGPhhyQZJqQeIYSFA0Vj5sL4PjCtZVk5oWM
	 4uO+R6O4hUEfiDb+rq7MUMuCxhvbxOPCpqWxeOTloqAC18533CZHloSjFzyaykZUej
	 GeRSbCvhmoVx2KeKYsXzHaAotJ+LGu6pU7DO0JnQubMCBouPNRnk7z1pjYXDnkggxj
	 BVNRoCgl4loxg==
Date: Sat, 5 Oct 2024 20:22:30 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, Christoph Hellwig <hch@lst.de>,
	stable@vger.kernel.org, bvanassche@acm.org,
	linux-block@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Stable backport request (was Re: read regression for dm-snapshot
 with loopback)
Message-ID: <ZwHYRg1rBi_nYNGb@sashalap>
References: <CACzhbgTFesCa-tpyCqunUoTw-1P2EJ83zDzrcB4fbMi6nNNwng@mail.gmail.com>
 <20241004055854.GA14489@lst.de>
 <CACzhbgT_o0B7x9=c10QpRVEm1FuNaAU3Lh0cUGQ3B_+4s21cLw@mail.gmail.com>
 <65e41cfb-ad68-440f-9e2b-8b3341ed3005@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <65e41cfb-ad68-440f-9e2b-8b3341ed3005@kernel.dk>

On Fri, Oct 04, 2024 at 07:22:24PM -0600, Jens Axboe wrote:
>On 10/4/24 6:41 PM, Leah Rumancik wrote:
>> Cool, thanks. I'll poke around some more next week, but sounds good,
>> let's go ahead with 667ea36378 for 6.6 and 6.1 then.
>
>Greg, can you pickup 667ea36378cf for 6.1-stable and 6.6-stable?

Queued up, thanks!

-- 
Thanks,
Sasha
