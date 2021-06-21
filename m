Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04332C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 22:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00596124B
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 22:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFUW7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFUW7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 18:59:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAD7C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 15:57:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k42so9653271wms.0
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 15:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZVbwwPHk5t4HxbGHQzPEO/p0gqz6k83G85nMRK/RZ3s=;
        b=EuQirQ7hYbcX3QkKm0DARayYZZ7pbX3/yw9mFBld2LQIqYIe4XVAQIi02E4couT4iN
         vdfe9jZ+hlvsC2oqbSRtB+RkYr5Xxtyi1VrG9l1kicEZz9RM4s8VKvZLJEEJX3hCZUl+
         rPWbqteO2fygqdQGavzpuL/LH5I0iXxztX8z27mYUSH2duqzZCZR7jEqqEMTHyOQ2Nfl
         28j8DMHzlyavB2dKm/g3pjmk1Ty0pwfpP9r3QXI6AmmjH4S4p645YS607KtCeAosPGM/
         vtjcJh/mFJG6pic2h2mkY+FnKyEW7NxZ0HycolqaIfItaL1vSkYhBxAtJSbTSxEUqalv
         Q59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZVbwwPHk5t4HxbGHQzPEO/p0gqz6k83G85nMRK/RZ3s=;
        b=YJYj4bWRQOiW7AyLElBJhUs7qEjGLhjtEEOUKqit6RRK1D2r2sFF2hLAcvcw6DW8Xe
         3rl70mhT34Mn1muMXB2dLA286WUN4bn6eXsACtS7/BTfqgqzEZA1N6yHvl00OOWOeqSB
         hiP61ToRyOD8Ltkt075obyzESHEZy420/Fq1BxY2xGPNLTxFmV80MmRdqWxhqjgj4DzU
         2qCKeZ7qMFGovWiYobWBvNkzVCc6/gM1RB8lODeLWftNQXUNbCRPY7Xs0CXNVDIWpPhZ
         WtROgI7KGX0NAlRV2f6IH0Z5Mv1TYoELZ2F97INpTSubpW5LYgm3RlspmXpP6Hdf+yOG
         RCOg==
X-Gm-Message-State: AOAM533DcWRbUe+/wxIzLnvLtg8OI0IU88V70Jnza9bfjylsyhK1EppR
        +65wnSFVUZMb6HxyW2ODSmwKUu9WSxzetw==
X-Google-Smtp-Source: ABdhPJxq6X2TfMUw9RRxYe6EFXUNo66o0xLa+V9TZc1G8ZBbYvbAFXaxTX2ai7Rjqon26KLx45o8kw==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr968901wmq.154.1624316241276;
        Mon, 21 Jun 2021 15:57:21 -0700 (PDT)
Received: from [192.168.8.197] ([148.252.132.93])
        by smtp.gmail.com with ESMTPSA id t128sm423369wma.41.2021.06.21.15.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 15:57:20 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=e2=9d=8c_FAIL=3a_Test_report_for_kernel_5=2e13=2e0?=
 =?UTF-8?Q?-rc6_=28block=2c_b0740de3=29?=
To:     Matthew Wilcox <willy@infradead.org>,
        Veronika Kabatova <vkabatov@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, CKI Project <cki-project@redhat.com>,
        linux-block@vger.kernel.org
References: <cki.3F4F097E3B.299V5OKJ7M@redhat.com>
 <CA+tGwn=+1Evv=ZZmOdXSpfUTG_dPvHfDsxbmLyHWr9-XkXA1LQ@mail.gmail.com>
 <CA+tGwnn4J2=WuPEFOwmC6ph30rHXJLhjH-iWmvkKLpacmR7wdQ@mail.gmail.com>
 <42b91718-9d70-4e4c-2716-6259321abd64@kernel.dk>
 <CA+tGwn=8KMpRi+6M-Lcs5MjKTkPd36YL5wv84Ji2dEWLjzfDmA@mail.gmail.com>
 <YNELoqls01MVLsuT@casper.infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <8a7b26a3-a17d-e851-690a-5a33b06f5dec@gmail.com>
Date:   Mon, 21 Jun 2021 23:57:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YNELoqls01MVLsuT@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 10:58 PM, Matthew Wilcox wrote:
> On Mon, Jun 21, 2021 at 11:07:16PM +0200, Veronika Kabatova wrote:
>> On Mon, Jun 21, 2021 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> On 6/21/21 2:57 PM, Veronika Kabatova wrote:
>>>> On Mon, Jun 21, 2021 at 9:20 PM Veronika Kabatova <vkabatov@redhat.com> wrote:
>>>>>
>>>>> On Mon, Jun 21, 2021 at 9:17 PM CKI Project <cki-project@redhat.com> wrote:
>>>>>>
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> We ran automated tests on a recent commit from this kernel tree:
>>>>>>
>>>>>>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>>>>             Commit: b0740de3330a - Merge branch 'for-5.14/drivers-late' into for-next
>>>>>>
>>>>>> The results of these automated tests are provided below.
>>>>>>
>>>>>>     Overall result: FAILED (see details below)
>>>>>>              Merge: OK
>>>>>>            Compile: FAILED
>>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> the failure is introduced between this commit and d142f908ebab64955eb48e.
>>>>> Currently seeing if I can bisect it closer but maybe someone already has an
>>>>> idea what went wrong.
>>>>>
>>>>
>>>> First commit failing the compilation is 7a2b0ef2a3b83733d7.
>>>
>>> Where's the log? Adding Willy...
>>>
>>
>> Logs and kernel configs for each arch are linked in the original email at
>> https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/06/21/324657779
> 
> Which aren't there by the time they get to the original commit author.
> You need to do better than this; the Intel build-bot bisects to the
> commit which actually causes the error.

Matthew, I've just followed the link out of curiosity:

...
00:04:22 In file included from fs/orangefs/inode.c:14:
00:04:22 ./include/linux/fileattr.h:36:60: warning: â€˜struct fsxattrâ€™ declared inside parameter list will not be visible outside of this definition or declaration
00:04:22    36 | int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa);
00:04:22       |                                                            ^~~~~~~
00:04:22 ./include/linux/fileattr.h: In function â€˜fileattr_has_fsxâ€™:
00:04:22 ./include/linux/fileattr.h:13:10: error: â€˜FS_XFLAG_SYNCâ€™ undeclared (first use in this function)
00:04:22    13 |         (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
00:04:22       |          ^~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:13:10: note: each undeclared identifier is reported only once for each function it appears in
00:04:22    13 |         (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
00:04:22       |          ^~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:13:26: error: â€˜FS_XFLAG_IMMUTABLEâ€™ undeclared (first use in this function)
00:04:22    13 |         (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
00:04:22       |                          ^~~~~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:13:47: error: â€˜FS_XFLAG_APPENDâ€™ undeclared (first use in this function)
00:04:22    13 |         (FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
00:04:22       |                                               ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:14:10: error: â€˜FS_XFLAG_NODUMPâ€™ undeclared (first use in this function); did you mean â€˜FS_XFLAG_COMMONâ€™?
00:04:22    14 |          FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
00:04:22       |          ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:14:28: error: â€˜FS_XFLAG_NOATIMEâ€™ undeclared (first use in this function)
00:04:22    14 |          FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
00:04:22       |                            ^~~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:14:47: error: â€˜FS_XFLAG_DAXâ€™ undeclared (first use in this function)
00:04:22    14 |          FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
00:04:22       |                                               ^~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:15:10: error: â€˜FS_XFLAG_PROJINHERITâ€™ undeclared (first use in this function)
00:04:22    15 |          FS_XFLAG_PROJINHERIT)
00:04:22       |          ^~~~~~~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h:51:37: note: in expansion of macro â€˜FS_XFLAG_COMMONâ€™
00:04:22    51 |                 ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize != 0 ||
00:04:22       |                                     ^~~~~~~~~~~~~~~
00:04:22 ./include/linux/fileattr.h: At top level:
00:04:22 ./include/linux/fileattr.h:55:29: warning: â€˜struct dentryâ€™ declared inside parameter list will not be visible outside of this definition or declaration
00:04:22    55 | int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
00:04:22       |                             ^~~~~~
00:04:22 ./include/linux/fileattr.h:56:64: warning: â€˜struct dentryâ€™ declared inside parameter list will not be visible outside of this definition or declaration
00:04:22    56 | int vfs_fileattr_set(struct user_namespace *mnt_userns, struct dentry *dentry,
00:04:22       |                                                                ^~~~~~
00:04:22 ./include/linux/fileattr.h: In function â€˜fileattr_has_fsxâ€™:
00:04:22 ./include/linux/fileattr.h:53:1: error: control reaches end of non-void function [-Werror=return-type]
00:04:22    53 | }
00:04:22       | ^
00:04:22 cc1: some warnings being treated as errors
...

-- 
Pavel Begunkov
