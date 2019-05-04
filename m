Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF4C46470
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 01:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7B62082C
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 01:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfEDBPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 May 2019 21:15:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40675 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfEDBPT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 May 2019 21:15:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3502536plr.7;
        Fri, 03 May 2019 18:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=a9IXq1ExE3LjBqi16WuQaXq/l5pxcNR9gCGN3rok/Ak=;
        b=drPha09l8ornjRRh0t2yyNmeujW4bqTPr/yR/vaozRTGRrZNggPswNG2Nw6RZU6H6R
         XpRWEBkWxZJsHFSAQlC42u96nUn376pwCSoNtcuzRgA8lHbx8GsCNwYVJ8eFilnfwm92
         roEPrA6Zojn4ubjxnPw79wnGsgE2RGLY4vXQRiJy5DNTcMDF2XzZK1UKhHM5h07jd68D
         Xcoy7kiXM685BnrHDP9b6K1s6Qnc01FJTMVLdybL7hO4G4tjOSE3eliCr4OUBsLEWPtV
         wV3umo+OHO3sbmtdiG7VuY57Bcv2QWL9T7HV6Q0Ra/XQJzsZUsHnx20A1QbC55BpxnV3
         /HPw==
X-Gm-Message-State: APjAAAWnmupasYdVwBqy1MPemjztT6vIbcGw8xedXn+anQjygtJzDNv+
        +lJSF6F3QjuFTdOdSlIuB8yTyZ5T
X-Google-Smtp-Source: APXvYqzLQm/VwjCjeibtxTsonIuvUl/wEsrh5GUCvnUSEzJDjjrpwxojlgclByE7lybGUbrravG1WQ==
X-Received: by 2002:a17:902:7287:: with SMTP id d7mr14937211pll.186.1556932518486;
        Fri, 03 May 2019 18:15:18 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id h30sm8830268pgi.38.2019.05.03.18.15.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 18:15:17 -0700 (PDT)
Subject: Re: blkdev_get deadlock
To:     Evan Green <evgreen@chromium.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>
References: <CAE=gft4irmMAapAj3O0hWr53PnyRUmcX2AJB+p_PqCJHT0rvNg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <ca507480-0b06-5e4d-ebe6-464302d3af92@acm.org>
Date:   Fri, 3 May 2019 18:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft4irmMAapAj3O0hWr53PnyRUmcX2AJB+p_PqCJHT0rvNg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------78929E0BE3A126298D42A8E9"
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------78929E0BE3A126298D42A8E9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 5/3/19 10:47 AM, Evan Green wrote:
> Hey blockies,
  ^^^^^^^^^^^^

That's the weirdest greeting I have encountered so far on the
linux-block mailing list.

> I'm seeing a hung task in the kernel, and I wanted to share it in case
> it's a known issue. I'm still trying to wrap my head around the stacks
> myself. This is our Chrome OS 4.19 kernel, which is admittedly not
> 100% vanilla mainline master, but we try to keep it pretty close.
> 
> I can reproduce this reliably within our chrome OS installer, where
> it's trying to dd from my system disk (NVMe) to a loop device backed
> by a removable UFS card (4kb sectors) in a USB dongle.

Although this is not the only possible cause such hangs are often caused
by a block driver or SCSI LLD not completing a request. A list of
pending requests can be obtained e.g. by running the attached script.

Bart.

--------------78929E0BE3A126298D42A8E9
Content-Type: text/plain; charset=UTF-8;
 name="list-pending-block-requests"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="list-pending-block-requests"

IyEvYmluL2Jhc2gKCnNob3dfc3RhdGUoKSB7CiAgICBsb2NhbCBhIGRldj0kMQoKICAgIGZv
ciBhIGluIGRldmljZS9zdGF0ZSBxdWV1ZS9zY2hlZHVsZXI7IGRvCglbIC1lICIkZGV2LyRh
IiBdICYmIGdyZXAgLWFIIC4gIiRkZXYvJGEiCiAgICBkb25lCn0KCmlmIFsgLWUgL3N5cy9r
ZXJuZWwvZGVidWcvYmxvY2sgXTsgdGhlbgogICAgZGV2cz0oJChjZCAvc3lzL2tlcm5lbC9k
ZWJ1Zy9ibG9jayAmJiBlY2hvIC4vKikpCmVsc2UKICAgIGRldnM9KCQoY2QgL3N5cy9jbGFz
cy9ibG9jayAmJiBlY2hvIC4vKikpCmZpCgpjZCAvc3lzL2NsYXNzL2Jsb2NrIHx8IGV4aXQg
JD8KZm9yIGRldiBpbiAiJHtkZXZzW0BdfSI7IGRvCiAgICBkZXY9IiR7ZGV2Iy4vfSIKICAg
IGVjaG8gIiRkZXYiCiAgICBwZW5kaW5nPTAKICAgIGlmIFsgLWUgIiRkZXYvbXEiIF07IHRo
ZW4KCWZvciBmIGluICIkZGV2Ii9tcS8qL3twZW5kaW5nLCovcnFfbGlzdH07IGRvCgkgICAg
WyAtZSAiJGYiIF0gfHwgY29udGludWUKCSAgICBpZiB7IHJlYWQgLXIgbGluZTEgJiYgcmVh
ZCAtciBsaW5lMjsgfSA8IiRmIjsgdGhlbgoJCWVjaG8gIiRmIgoJCWVjaG8gIiRsaW5lMSAk
bGluZTIiID4vZGV2L251bGwKCQloZWFkIC1uIDkgIiRmIgoJCSgocGVuZGluZysrKSkKCSAg
ICBmaQoJZG9uZQogICAgZmkKICAgICgKCWJ1c3k9MAoJY2QgL3N5cy9rZXJuZWwvZGVidWcv
YmxvY2sgPiYvZGV2L251bGwgJiYKCSAgICB7IGdyZXAgLWFIIC4gJGRldi9yZXF1ZXVlX2xp
c3Q7IHRydWU7IH0gJiYKCSAgICBmb3IgZCBpbiAiJGRldiIvbXEvaGN0eCogIiRkZXYiL2hj
dHgqOyBkbwoJCVsgISAtZCAiJGQiIF0gJiYgY29udGludWUKCQl7IFsgISAtZSAiJGQvdGFn
cyIgXSB8fAoJCSAgICAgIGdyZXAgLXEgJ15idXN5PTAkJyAiJGQvdGFncyI7IH0gJiYKCQkg
ICAgeyBbICEgLWUgIiRkL3NjaGVkX3RhZ3MiIF0gfHwKCQkJICBbICIkKDwiJGQvc2NoZWRf
dGFncyIpIiA9ICIiIF0gfHwKCQkJICBncmVwIC1xICdeYnVzeT0wJCcgIiRkL3NjaGVkX3Rh
Z3MiOyB9ICYmIGNvbnRpbnVlCgkJKChidXN5KyspKQoJICAgICAgICBmb3IgZiBpbiAiJGQi
L3thY3RpdmUsYnVzeSxkaXNwYXRjaCxmbGFncyxyZXF1ZXVlX2xpc3Qsc2NoZWRfdGFncyxz
dGF0ZSx0YWdzKixjcHUqL3JxX2xpc3Qsc2NoZWQvKnJxc307IGRvCgkJICAgIFsgLWUgIiRm
IiBdICYmIGdyZXAgLWFIIC4gIiRmIgoJCWRvbmUKCSAgICBkb25lCglleGl0ICRidXN5CiAg
ICApCiAgICBwZW5kaW5nPSQoKHBlbmRpbmcrJD8pKQogICAgaWYgWyAiJHBlbmRpbmciIC1n
dCAwIF07IHRoZW4KCSgKCSAgICBjZCAvc3lzL2tlcm5lbC9kZWJ1Zy9ibG9jayA+Ji9kZXYv
bnVsbCAmJgoJCWlmIFsgLWUgIiRkZXYvbXEvc3RhdGUiIF07IHRoZW4KCQkgICAgZ3JlcCAt
YUggLiAiJGRldi9tcS9zdGF0ZSIKCQllbHNlCgkJICAgIGdyZXAgLWFIIC4gIiRkZXYvc3Rh
dGUiCgkJZmkKCSkKCXNob3dfc3RhdGUgIiRkZXYiCiAgICBmaQpkb25lCg==
--------------78929E0BE3A126298D42A8E9--
