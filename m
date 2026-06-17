Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DDE3921DE
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687604; cv=none; b=D62h7udFvmA8wOWg/aG3rW78yO5VsbHzwJ3z/d8q6DoRVr/1mVjCqdzsN2RwPvsK9LJSWlU+QOuNfSwJTqNbsxbq4ccsX8mfpEsLaOW3IiSOYDjohvMGC5T4zBG6N3QMHF4el+lyT8RST27hFb6T5w7JalM3xZ5yIp3uoPss7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687604; c=relaxed/simple;
	bh=VNb8Oeo8fsnl2dNubUFSWKcRBi3wEZOagsaNZh7wB14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHALKnvOoaaLhPg1pTaj8NC/EASI2edW2U8VzueD7WNhWf9FmNi9TWcApAcIGMagKWGScBOvdg1vfpb7NOnYsrgJRmvzEdmrp8DF9m7yHUSofjxddEUOhjy4bGJREt5ohHrqCjcUifv3/5tGkZed+GIwsE35OWTsf6lllb4IBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXPlLkEF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXPlLkEF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso5839295e9.0
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687597; x=1782292397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdzEnJF2ilqo5mGBwtUC4XQR13hh+SJ7AGP/8bu8ACk=;
        b=CXPlLkEF+mjs8vpLhTWd+Sc6t6QohlDW0zR+1qcMjm4Su3Jd32HU2gmk3tPPTWwaNP
         p9ssRghKH/qE8kop/lDoIOGRnrReIUl1o2il41jH0H49gm4lnXzQzLptSBCUj5j9fKQv
         EU+PWayJVz916sv4cYsraFktqAZx98W+EwtlHyw24vzczbsTM+LAoMcoHaSVW++876zX
         P3iJ/62XtmEQ8fnKOLJvA6DPlQK+v2XT3snuEaU3mmisnQLKl5Q3dwRQBaDaX8slWqWS
         RsyYUdHifQo7y0YeDmzP4nB0vvmJlfur2CQGxUonbu7xpZLhA88JF1/R/TwQYSve1V/l
         ECxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687597; x=1782292397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdzEnJF2ilqo5mGBwtUC4XQR13hh+SJ7AGP/8bu8ACk=;
        b=iPAOfG1O4NCUL/9cy7rvZwHyezUu+RePlEN5GqKBNO4BOB8/ADiKYP0Yt4vaLd6efJ
         UHwywLvY0nrPz18kidpccGjCHG/varS/m4CiaLS8KwzTFzvgeRHCh7dfwKnsmjoF4F/k
         X3F2rW0C9Gz0xZ3Q3uAS8vMF1VW9kiHhJRd0SRuLJv+9ltx/3+2tK1YoQtjigfOW28t/
         ixB5tz6AzjNRUvv/OamEDMIukJevA5iHvQoBPgppgKCzXn47Jpfl1x0yBMOqW9oi9rzS
         ySTa+pDKxeP/EMip/VXL/GX6ypwFJPfCWeSj4jTXVTcTyAqDG3k1m6Z64j0oi0fIyPbW
         Iu2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/N4pya2ZnqyJRVQ9GRLwowMeZQa2CxAk0G7r4yh8ES4giB7gOxOkvmsjN34eJEeMb8TwrDTQTBYUnPHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydF55/XfBDUVwMFahgHlUHUAII7TI5PKnaULQabycBlbsujxQG
	HHVmqFzArcokhBheSXHJE8i4W2yeNSAyvnMHvl/UwxfbOhYhKoJDvovB
X-Gm-Gg: Acq92OGVkGdTfQYo1AuHlBmSlfUwOMBOBqZF3LCDl3/JHBM3f0JUwe/IzFOsh98SAwp
	2KXJikf9/iYFoi+cCyTTQ8ll2tOmSCoPXv/Vcz/g+8F4URHR1EdxncJ8JUq6SUMMEfn9cc/QHz2
	sOtgH8mJxpBgIwW9WU5vV9zkun3MwSa34oLZuziC7t2hXi/wGgCURiQJ7nA+pllwaE2z1oUY1Gu
	PcUQL+OZwo7ST8A2vZR3pxL+hd6ZYE5WmIhbnJfyNIVvpuM95JcCUU15y5xZka5z7FLyEhucVKp
	VLdcOUXZUXI16LRYrxTQM7C6a2KzQmRywgvLZzJHDGTPkdNF4YDILfWVMyqiCxWlvyjdDB8lyhy
	a6E3+AB+w46nW2dXbj5sZH4u08NH6fR6etbNImbrR7L9HxgA6t3wYVmaEUG3x2MsOx7BAF2jlXZ
	B5f0+LYpA+KkpFmAdTWRMnsBtgQBJvOpzQonmE/i55NsSiDf8F+dPC
X-Received: by 2002:a05:600c:5290:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-492340c604emr29094785e9.7.1781687596953;
        Wed, 17 Jun 2026 02:13:16 -0700 (PDT)
Received: from [172.16.16.38] ([195.100.225.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a0e9e4sm130471915e9.0.2026.06.17.02.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 02:13:16 -0700 (PDT)
Message-ID: <75552e2d-0bc8-40a0-b783-fba64482aea9@gmail.com>
Date: Wed, 17 Jun 2026 11:13:14 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: add procedural macro for declaring configfs
 attributes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao
 <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260612-configfs-syn-v3-1-3292fbc5cc32@gmail.com>
 <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
Content-Language: en-US, en-AU
From: Malte Wechter <maltewechter@gmail.com>
In-Reply-To: <CANiq72=RX5V6W+1tj0GHxZusrk5OqYbZ5-xV=wvSssrx_CWXAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/13/26 12:41 PM, Miguel Ojeda wrote:
> Hi Malte,
>
> Some quick notes...
>
> On Fri, Jun 12, 2026 at 3:29 PM Malte Wechter <maltewechter@gmail.com> wrote:
>> +/// ```ignore
> Empty /// before examples.
>
>> +///     // This will extract "foo: <field>" into a variable named "foo".
> ` instead of "
>
> i.e. please use Markdown
>
>> +///```
> Missing space indentation
>
>> +/// Expands the following output:
>> +///    let item_type = {
> Missing example block, both at the beginning and the end.
>
> Please double-check by generating the docs and looking at how they
> appear in the browser.
>
> The prefix of the title should likely be `rust: configfs:`.
>
> Thanks!
>
> Cheers,
> Miguel
As of now doc strings are not generated for private items in the macros 
crate. I am moving the `parse_ordered_fields!` macro into 
macros/helpers.rs but this means the doc strings are not generated for 
the macro anymore. The `parse_ordered_fields!` macro is a larger helper 
function, and the doc strings are relevant and helpful for macro 
developers that wants to use it.

You can enable documenting private items:

diff --git a/rust/Makefile b/rust/Makefile
index b361bfedfdf0..b4239443307e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -147,6 +147,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
      OBJTREE=$(abspath $(objtree)) \
      $(RUSTDOC) $(filter-out $(skip_flags) --remap-path-scope=%,$(if 
$(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
          $(rustc_target_flags) -L$(objtree)/$(obj) \
+        --document-private-items \
          -Zunstable-options --generate-link-to-definition \
          --output $(rustdoc_output) \
          --crate-name $(subst rustdoc-,,$@) \

But this enables _all_ private items to get rendered, which is not 
ideal. How should i proceed?
Best regards,

Malte


