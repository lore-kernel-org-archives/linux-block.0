Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79325B0B0
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614137; cv=none; b=h7WXS9J4+y6+3TrurmeRZy7+UpqjP3C34pHpk2J+2WHXOpwvLu7NPOxnZT7ixcoVPBMWJshdoAyk0hmJnmD23YItlJAe3b6fITfbMnVxxf77MCzCpkqlEgExnJeEYGg/gcGeOpJoe84GWsbgpUqjSxKAbDpLGPWQ68VXBJwd0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614137; c=relaxed/simple;
	bh=5NBDeyx3AzjMfkzZylUmP/Rv69iLbu6wiY0g3mpQPUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdpFiLIRc4KVFyv1i7IVOfBtzZYsOcjRzVY0jQ3iRY16/77SBIwrnghiD/1/8Yz8dQgJax44pKPsQcvviF48BEhFv6D3OgsZc1hluZL8wdSSIAZubQ5g1wHzZoGq2OQMv9JB/uquMVccI7BEYXcgk5K5l/E6uyGzFj2VALApqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fvo6/z3H; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fvo6/z3H"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gFRTz54Ctz1XM5kD;
	Tue, 12 May 2026 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778614132; x=1781206133; bh=mp6BA131EzzVN0wIrKuaoaXT
	gkb2LEeDiNgtO6cxED8=; b=fvo6/z3HR7PeJ1o/NF38gZANaZIS7HjslXPNlZLB
	sHOfJgg8smWsDAMHn+9zXUNUOu7sly8ZU6OLE7+3e2Py8yX7lwsZUF4Jy7lDncxL
	LuR0FJVNly/12xp8uzoeq4Rlzqo4wfLoM5pCrLvC55fawHz41xchiRAMhcVrDuCd
	WPp8cZCw6pESoUFai7w/x8MbaoP5qJnrbyNEIGhpHksgoZHYpIoc8S23j2ElT2xj
	k2h/3WHDCetdMQ78qlzHk4zG5NpU5BkWeEUOZjtAinW0eCHQplRB0ORNQdT1euZv
	wiz3yPyELupBd5K/nQIp1crEtNFcffzDnOAf431ggcPDnw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f10nOklHl644; Tue, 12 May 2026 19:28:52 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gFRTv3GRBz1XM5jn;
	Tue, 12 May 2026 19:28:50 +0000 (UTC)
Message-ID: <56a1f905-2348-483b-a79e-5b3ebbd3482d@acm.org>
Date: Tue, 12 May 2026 12:28:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops callback
 functions
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20260511163100.1887263-1-bvanassche@acm.org>
 <20260511163100.1887263-3-bvanassche@acm.org>
 <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/26 3:19 PM, Marco Elver wrote:
> On Mon, 11 May 2026 at 18:31, Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> The four callback functions in blk_holder_ops all release the
>> bd_holder_lock. Annotate these functions accordingly.
>>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Because of this change we'll need clang 23, or you add:
> 
> CONTEXT_ANALYSIS := $(call clang-min-version, 230000)
> 
> .. although anything else that includes blkdev.h that has
> CONTEXT_ANALYSIS := y, but is compiled with clang 22 will break.
> 
> Would have been good to wait for clang 23 to be released (August this
> year) - although if we consider the next merge window + final release
> of Linux 7.2, it might get reasonably close to August.

Hi Marco,

How about detecting whether or not Clang supports context annotations
for function pointers, e.g. as follows?

diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308ae..61e592205179 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -32,6 +32,9 @@ config CLANG_VERSION
  	default $(cc-version) if CC_IS_CLANG
  	default 0

+config CC_CONTEXT_ANNOTATIONS_ON_FUNCTION_POINTERS
+	def_bool $(success, echo 'struct __attribute__((capability("m"))) m { 
}; struct a { void (*fp)(struct m* m) 
__attribute__((release_capability(m))); };' | $(CC) -x c - -c -Wall 
-Wextra -Werror -o /dev/null)
+
  config AS_IS_GNU
  	def_bool $(success,test "$(as-name)" = GNU)


Thanks,

Bart.
