Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07671B6D1A
	for <linux-block@vger.kernel.org>; Sun, 23 Aug 2026 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494166; cv=none; b=F8We78r5CSFl/ULTWc87meS2VnTy4rLActGaloGHdOT/HdOGYLQQYwSRPcYe9OXhqrY6Ncjo6mxRqlTALDKV9tONX/4Qlbyt1/p0hzJdzheabn6v4AAK3i/fLDrLlOgQaZR+H0mhZHj/bCFktMzG54aMKhtMvdKUAaYhrfY7NsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494166; c=relaxed/simple;
	bh=2+aRfnNauA6J2unP3OzdwMUS3jAzTb+QsWHr63GAF64=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hJBFw7cm//dv490uQ0cCQBqF5+PIZdRJZAU2fpxNuMXHTy3yK7RzNK3VTzRzHJUhuwnBavyjSXBWCPF9k+4CjJgrQ6zjUG/quv3L4H9VhX4/cGWPwjDxJWqzPUpWzp1HPjVoL6w8HO1rcdR+zmIomUorOK/WwQOiciUDV58rAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67NE9Lu5071845;
	Sun, 23 Aug 2026 23:09:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67NE9LiO071841
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 23 Aug 2026 23:09:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8507ead0-fc7c-43dc-befe-7bbf1cb201f0@I-love.SAKURA.ne.jp>
Date: Sun, 23 Aug 2026 23:09:20 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [block] general protection fault in lo_rw_aio
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: Gary Guo <gary@garyguo.net>, Mark Brown <broonie@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Boqun Feng
 <boqun@kernel.org>, Theodore Tso <tytso@mit.edu>,
        kernel test robot <oliver.sang@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <cdf41ad3-783f-4a14-8343-c893d6c50524@I-love.SAKURA.ne.jp>
 <f5cb9935-1497-474a-8e96-661914f18a71@I-love.SAKURA.ne.jp>
 <4e62dfee-53f4-4cb0-b92d-f2ce9a5b0852@acm.org>
 <34c3f72d-1d4f-4e0f-bc06-bc562e39a6f6@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <34c3f72d-1d4f-4e0f-bc06-bc562e39a6f6@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp

On 2026/08/22 10:02, Tetsuo Handa wrote:
> On 2026/08/22 2:32, Bart Van Assche wrote:
>> On 8/21/26 5:46 AM, Tetsuo Handa wrote:
>>> On 2026/08/03 22:34, Tetsuo Handa wrote:
>>>> I am waiting for your response on
>>>> "[PATCH v5] loop: Fix NULL pointer dereference in lo_rw_aio()" at
>>>> https://lkml.kernel.org/r/30ccdd3c-6353-4a0f-bdc7-230ec3bf4765@I-love.SAKURA.ne.jp .
>>>
>>> You have never responded for 4 months since I first contacted you at
>>> https://lkml.kernel.org/r/e1d824ba-9ac7-4fde-a791-32eeadcd4258@I-love.SAKURA.ne.jp .
>>> Nobody being interested in this problem has caused multiple issues for linux-next tree.
>>> Will you become responsive on this problem?
>>
>> Since I didn't like the proposed solution I took a look at this issue
>> myself. If nobody objects I will integrate the patch below in my loop
>> driver patch series.
> 
> Here is a review comment from AI Mode in Google Search.
> I and Google consider that your patch is not sufficient.
> At least your patch should be reviewed by sashiko, by posting your patch to ML.

I found your patch in https://github.com/bvanassche/linux/commits/block-loop/ .
Unless you update your patch in a form that can be applied as a single patch
against linux.git tree (without any prerequisite patches), I don't think that
sashiko can review your patch...

