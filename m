Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0C250F2
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524550; cv=none; b=bp3aU+7CjHd8OcTOO+sw+CrQLHCrAP0BP3s8OpEwODpAXlha1ZHJgw29wbWXx426AwUqIYUEjYaFpOaGZI9Q3j+iG6JBSUXsP3wEl8WtwXETNg0Acf/W2Kb66mDh/0riveyy7SPDFId3yaONRHMYxbzkROMnY0wzdQsjGfKNuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524550; c=relaxed/simple;
	bh=4C3B38j6AISA7EFei65uH/rAKGkuuBqYqnyrUgi5i70=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=V1iIjNlATcRgLFFu/zXui46f2dpD6PwcRBUuLiCgfkRAtDUT9GOqfJ2JdE56RJCq1u7Cc5Q46A0XWJv2yGkY6M6TY31/xR/Yd3vQ6lKiPEsu8Ep/hDEo3+5/odS8xHiW0gjGhX0a+3igK7lqUU2MAgWWUkK5eyRFJgzo3e72QXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s+t2cTlC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s+t2cTlC"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bee9f626caso59154039f.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 12:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705524547; x=1706129347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEqWycOCXklKwHJrU6Ntuml01jaBPB2WzfYgmiXRzhA=;
        b=s+t2cTlCvHiVxqCJsSWJiTcMJIzBwVzhte/mm7AFcLIkrHimJhBjhOFkiI74gjpebl
         Klu+KmF4jM1N3kDS0WGR0syu05t474X1EnMEWD+8zegar0W5BLjVVCR+nnzgj43S8vhQ
         +t5ikZvxTs9Yqb2mLz+JU9SWdLM5KzHTm7CupTXOxTO6CKU/qXxrg2bJX55qrLl2Sn3y
         MijXMlwMtGWhgWChtvg0t/ck0fFL8KoYd/te7u8GuXSCPLGG1IWBn+pH3xiQ7kgqX0V4
         m24OQ0/WCd0VumuqSdDUV47YzXmaAQqsoQTlmL0cvv35vFRRjqPRi833amfxPZlHQUof
         A9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524547; x=1706129347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEqWycOCXklKwHJrU6Ntuml01jaBPB2WzfYgmiXRzhA=;
        b=SJfIutdzaVW2gCwSv2m7kEWJgpKg1XL8xYMfb6umfRBiKjTPF3v9awkp5sm6uw0NZl
         CVMFXTiSTpdHCkyJ9eXkoFyV0aYjEUTls8eZn32aT25raEHb6wwf7TPgtKeJSYtyaVBI
         gM8TZGm+d4Tc/t5Tr7cX2fiIYe0p4428t5kCi5WTr7+rotIPNNaAUS0V0JI/LGYplmNa
         tw4NDfZlE3qRV3bXyLb+QObxd+ORqvUp+P4L/rJzDloM1sBPNb+z/u5tbWDfMYXPuTU4
         86MSN/017bMWxZf8VnOIVcXwnmMR0FWm4D/QWn0fprKS15qeTX4+wlcjpeibVPC1OPfo
         mlwA==
X-Gm-Message-State: AOJu0YzxXqziVEGG2P22Eznj0Yy0QhLgeLl7MyldsIL+VNYJPxmfbvRu
	atRKr3HdPIgzpnyo1IEa529p9/atS+0KU3hYG2FfPWuVZh1QKw==
X-Google-Smtp-Source: AGHT+IEjRpGVhaFU6GQOSITwHA5dLJ9g/8qSvX/EUdHpacX5d6qmKS8FX83UqFSz55Sewlu/m7mG+w==
X-Received: by 2002:a5e:834b:0:b0:7bc:2603:575f with SMTP id y11-20020a5e834b000000b007bc2603575fmr3382789iom.0.1705524547502;
        Wed, 17 Jan 2024 12:49:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id fx24-20020a0566381e1800b0046ea0f4c0aesm608022jab.81.2024.01.17.12.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:49:06 -0800 (PST)
Message-ID: <9f843575-ef22-489e-8c1a-f67d664a1be1@kernel.dk>
Date: Wed, 17 Jan 2024 13:49:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race in block/blk-mq-sched.c blk_mq_sched_dispatch_requests
Content-Language: en-US
To: Gabriel Ryan <gabe@cs.columbia.edu>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <CALbthteVP3BnZuQuGWfW-SviB64CwjACP2v1N5ayDVFpnjEOtw@mail.gmail.com>
 <e4347147-f88f-4a83-ac48-fde1af6a89e9@kernel.dk>
 <37b7836b-f231-4bf5-bee1-7571f889d6ff@acm.org>
 <3f676f69-690a-480c-850d-ff1d9e502e4f@kernel.dk>
 <CALbthtdU8=yiaq7wzQegf52M0A+a=MUzcHvaM-FeLSHZvrfQkA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CALbthtdU8=yiaq7wzQegf52M0A+a=MUzcHvaM-FeLSHZvrfQkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/24 1:36 PM, Gabriel Ryan wrote:
> Thank you for the response Jens, and apologies I did not realize that
> the variable is only used for debug output before sending this report.

No worries, but please do some due diligence on reports from a tool
before blindly sending them out. This will help reduce time waste on
both sides.

I'd also strongly recommend you upgrade to a recent kernel rather than
something that is 2 years old.

-- 
Jens Axboe

