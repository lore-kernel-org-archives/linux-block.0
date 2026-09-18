Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CFC50B41B;
	Fri, 18 Sep 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747472; cv=none; b=bBc3U8byrGT7phR/KPm1DlPSI82VpMg7fZySUKTi+qQh+1fdf7Nn2SakuJg4HvlWbDoly8SxPKH0aqX9JFhbhtjHSPz0Xta63CWTqKXQmLoeXTfcCLqnKZ8j02aoDqb7hivfGhJHx2DMzUsFRggITC1LfXnmxrjVvrwtqxnIRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747472; c=relaxed/simple;
	bh=au8k22jfC3bJ2/Bf9bixr38gBeGuvtqbFwh+Y46n5RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnhFHkUgKjOyRjs1p5t5Ujk8qrFC+sdSSI1mf+lH7MANOLvJCLOKJ4z8+UGyIRZJBsDxfb71JttkUG79ZRRKYM5KmiCGszWCQZZ86OBmcUTxK7QMnW9/J1dTCMxkW8yaRSzELpoeHdrfe2KQHZPQ068RnuUphNtDoeqLwMgMTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68IG36n4084911;
	Sat, 19 Sep 2026 01:03:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68IG36iq084907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 01:03:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <760558e1-7b19-4686-9d3f-11fc1ccd8372@I-love.SAKURA.ne.jp>
Date: Sat, 19 Sep 2026 01:03:01 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] loop: Perform __loop_clr_fd() after
 disk->open_mutex is dropped.
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <f597b6e6-77a7-4c09-9d72-e5a9cbe6d7c2@I-love.SAKURA.ne.jp>
 <8ac41772-c397-4069-8878-7a1924e8b8a3@I-love.SAKURA.ne.jp>
 <b9fb6da9-00be-4fb0-853b-ae37cb917fc9@acm.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <b9fb6da9-00be-4fb0-853b-ae37cb917fc9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav312.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/19 0:49, Bart Van Assche wrote:
> On 9/18/26 8:00 AM, Tetsuo Handa wrote:
>>    for it seems that Vart wants to let current thread run __loop_clr_fd() instead of
>>    offloading to WQ context and letting current thread call flush_work(). Vart can apply
> 
> I see that my first name has been misspelled twice. Since it happened
> twice, this probably happened on purpose. Misspelling someone's name on
> purpose is childish behavior.

Sorry, I didn't know I was typing "Bart" as "Vart".

sashiko responded with a comment that not calling lo_post_release()
when lo_release() is called as an error-unwinding path can leave the loop
device permanently bricked in the Lo_rundown state
( https://sashiko.dev/#/patchset/f597b6e6-77a7-4c09-9d72-e5a9cbe6d7c2@I-love.SAKURA.ne.jp?part=2 ).

Although that comment is a false positive because lo_open() and lo_release()
are serialized by disk->open_mutex. If lo_release() is called as an error-
unwinding path, it is guaranteed that need_clear == false.

But do we want to make post_release() callback be called when release() callback
is called from open() path?

