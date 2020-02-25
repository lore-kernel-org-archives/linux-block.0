Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B7C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA44F2064A
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 15:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgBYPWw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:22:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51607 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgBYPWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 10:22:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so3422147wmi.1;
        Tue, 25 Feb 2020 07:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XS0gxsEB2/d2wHujrkBiw//O8MTAQ412gY6JtutxKOs=;
        b=rYORLGmqxaNYap4AWiJeZzARhFE3LxjLjQgOXB4d8Rbg6eOnANVeZ4rTTBxhmYXRF4
         tJEMJW/KWd1/VEH7Rgh1VOg41AwLt2Kj/ZFGROQc9KoUF8XpeV3t9YE+4AuVOAOfG/LJ
         O/O1aSe7XsIZnm+gQujnHV/3tmscRhlXa54epbpaksnUdAOHUhqO/azMSSINhwuqrbtb
         bIRNYFa90Y6AifP3GLY/L96Isoa3YEr5uTxdmkvYTJEBPD/1MnuXaf8H8uoz9Cf/LxMg
         Vv4Oz34Bu+1E6AoPkgeEc3g+lOJWgDs0bwwjnLwzR4aE3aM7raxsRnHejNtLuoTCXfIo
         hMWA==
X-Gm-Message-State: APjAAAXq5BF7gjqKziNAA0zHqVo1lhn2+UpFZVPfJ1oMAyS0BfixFB49
        4lvRVuGV242ZBneNHHSfGopThfXj
X-Google-Smtp-Source: APXvYqyh3e07RB9BZiKNsmdJ0w5BikkApEd6YO+3rwYV9JnSKJTqdhcD9CwShHofQW2kGrrUD+szZA==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr5718892wmd.69.1582644169826;
        Tue, 25 Feb 2020 07:22:49 -0800 (PST)
Received: from [10.10.2.174] (winnie.ispras.ru. [83.149.199.91])
        by smtp.gmail.com with ESMTPSA id r5sm23519875wrt.43.2020.02.25.07.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:22:48 -0800 (PST)
Reply-To: efremov@linux.com
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200224212352.8640-1-w@1wt.eu> <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
 <20200225034529.GA8908@1wt.eu>
 <c181b184-1785-b221-76fa-4313bbada09d@linux.com>
 <20200225140207.GA31782@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <10bc7df1-7a80-a05a-3434-ed0d668d0c6c@linux.com>
Date:   Tue, 25 Feb 2020 18:22:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225140207.GA31782@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/25/20 5:02 PM, Willy Tarreau wrote:
> On Tue, Feb 25, 2020 at 10:14:40AM +0300, Denis Efremov wrote:
>>
>>
>> On 2/25/20 6:45 AM, Willy Tarreau wrote:
>>> On Tue, Feb 25, 2020 at 02:13:42AM +0300, Denis Efremov wrote:
>>>> On 2/25/20 12:53 AM, Linus Torvalds wrote:
>>>>> So I'd like to see that second step that does the
>>>>>
>>>>>     -static int fdc;                 /* current fdc */
>>>>>     +static int current_fdc;
>>>>>
>>>>> change.
>>>>>
>>>>> We already call the global 'drive' variable 'current_drive', so it
>>>>> really is 'fdc' that is misnamed and ambiguous because it then has two
>>>>> different cases: the global 'fdc' and then the various shadowing local
>>>>> 'fdc' variables (or function arguments).
>>>>>
>>>>> Mind adding that too? Slightly less automatic, I agree, because then
>>>>> you really do have to disambiguate between the "is this the shadowed
>>>>> use of a local 'fdc'" case or the "this is the global 'fdc' use" case.
>>>
>>> I definitely agree. I first wanted to be sure the patches were acceptable
>>> as a principle, but disambiguating the variables is easy to do now.
>>
>> Ok, I don't want to break in the middle of your changes in this case.
> 
> So I started this and discovered the nice joke you were telling me
> about regarding FD_IOPORT which references fdc. Then the address
> registers FD_STATUS, FD_DATA, FD_DOR, FD_DIR, FD_DCR which are
> based on FD_IOPORT also depend on it.
> 
> These ones are used by fd_outb() which is arch-dependent, so if we
> want to pass a third argument we have to change them all and make sure
> not to break them too much.
> 
> In addition the FD_* macros defined above are used by x86, and FD_DOR is
> also used by arm while all other archs hard-code all the values. ARM also
> uses floppy_selects[fdc] and new_dor... I'm starting to feel the trap here!
> I also feel a bit concerned that these are exported in uapi with a hard-coded
> 0x3f0 base address. I'm just not sure how portable all of this is in
> the end :-/
> 
> Now I'm wondering, how far should we go and how much is it acceptable to
> change ? I'd rather not have "#define fdc current_fdc" just so that it
> builds, but on the other hand this problem clearly outlights the roots
> of the issue, which lies in "fdc" being silently accessed by macros with
> nobody noticing!
> 

I think that for the first attempt changing will be enough:
-static int fdc;                        /* current fdc */
+static int current_fdc;                        /* current fdc */
and
-#define FD_IOPORT fdc_state[fdc].address
+#define FD_IOPORT fdc_state[current_fdc].address
and for fd_setdor in ./arch/arm/include/asm/floppy.h

This already will require to at least test the building on x86,
arm, sparc arches (maybe more).

Just need to leave a note in the commit why it's not easy to
change FD_IOPORT in this case.

I think that small-step and observable patches are the best option
when we change floppy driver.

As for now, I can see that only floppy.c includes fdreg.h file
with define FDPATCHES. If it's true then #define FD_IOPORT 0x3f0 
branch is never used and we can try to fix remaining FD_* macro
in the next round.

Denis
