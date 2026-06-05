Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CC8378D9C
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654116; cv=none; b=hHR2r1RAhBT+DjJXK6HEPPC8GjMaQXx4+YBL9zGfgKApn7GEelCRfmcPMHpdR9InteYPpcaDzWivlu9AmQ1N8xC5WtDqPZU3fMXZ1sFjHJMZj8BoZL+AVLveb0SDlokIjndnWZ/Icqo7q3Eo6OzNYcLAOE/9MH7Jc1EckLr74hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654116; c=relaxed/simple;
	bh=Ws7DL6+IsqKE/SeXyr2AzSQmw/g4647ediva3wgyaZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdClIgCEJIUxPfNUY5/ePB/6VeQip/4oS8V+K3fb7lin4WkJc+15nwDjDO4zg4VdTV8LemXIn006OnsaSyZWLN3G66RhQJrPc365te0pwYvwddjMEuLyS3wge8AqrPrzMBsHaQ99nAPR7v+bTRpLyErRBeiKy3TGF8oXGQr+POw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 655A8QO8065036;
	Fri, 5 Jun 2026 19:08:26 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 655A8PpM065028
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Jun 2026 19:08:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <89f0f308-2ee7-4c68-b811-8132e5d88530@I-love.SAKURA.ne.jp>
Date: Fri, 5 Jun 2026 19:08:26 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to
 disk->open_mutex
To: Miguel Ojeda <ojeda@kernel.org>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
        dlemoal@kernel.org, hch@lst.de, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tom.leiming@gmail.com, wqu@suse.com,
        Andreas Hindborg
 <a.hindborg@kernel.org>,
        Boqun Feng <boqun@kernel.org>, rust-for-linux@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
 <20260604210704.41751-1-ojeda@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260604210704.41751-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp

On 2026/06/05 6:07, Miguel Ojeda wrote:
> On Wed, 03 Jun 2026 20:54:05 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>>
>> Acknowledgment:
>>   Since I have no experience with Rust, changes needed by Rust block layer
>>   bindings and rnull module are made based on conversation with the Gemini
>>   AI collaborator.
> 
> Then please do Cc the right people as `MAINTAINERS` mentions, including
> "BLOCK LAYER DEVICE DRIVER API [RUST]" and "RUST"...

Oops, it seems that I overlooked the rust-for-linux@vger.kernel.org line.

> 
> I am quite confused. Why was this added to linux-next?

Since sashiko did not find issues on this v3 patch
( https://sashiko.dev/#/patchset/226152a3-1e4c-4eec-9a17-1d40426a7b18%40I-love.SAKURA.ne.jp ),
I started pre-testing by syzbot while waiting for responses from maintainers.

I am using my tree for allowing syzbot to test debug/experimental patches in linux-next tree
(or to apply workaround patches for bugs that prevent syzbot from testing linux-next tree),
and therefore my tree is subjected to "git reset --hard" changes.

> 
> It doesn't go through block, nor has an Ack or review and breaks
> the `rustdoc` build in linux-next (and thus rust.docs.kernel.org):
> 
>     error: unresolved link to `my_gendisk_lkclass`
>       --> rust/kernel/block/mq/gen_disk.rs:42:50
>        |
>     42 | /// This type can only be instantiated via the [`my_gendisk_lkclass!`] macro.
> 
> It is also not Clippy-clean -- it doesn't follow our usual conventions
> for safety comments and sections:
> 
>     error: unsafe function's docs are missing a `# Safety` section
>       --> rust/kernel/block/mq/gen_disk.rs:59:5
>        |
>     59 |     pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {
> 
>     error: function has unnecessary safety comment
>       --> rust/kernel/block/mq/gen_disk.rs:59:5
>        |
>     58 |     /// SAFETY: `ptr` must point to a valid static `gendisk_lkclass` instance.
>        |         ------- help: consider changing it to a `# Safety` section: `# Safety`
>     59 |     pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {

Hmm, I'm not familiar with comment styles for Rust...

Do you see any technical problems except comment style problem?

> 
> Please see:
> 
>   https://rust-for-linux.com/contributing#submit-checklist-addendum
> 
> In any case, it is also too late in the cycle to be experimenting in
> linux-next.
> 
> So what am I missing? What is going on?

Nothing bad is going on. The final patch will be sent to linux-next tree via
appropriate tree after getting acks from maintainers, and the current patch
in my tree will be dropped when maintainers accepted the final patch.

> 
> (And on top of all that, for some reason I did not receive it even if I
> am apparently in Cc, so I have asked the admins about that.)

I was enabling only SPF, but it seems that gmail started rejecting such mails.
Therefore, last night I also enabled DKIM/ARC and DMARC. I hope this mail is
delivered to gmail users.

