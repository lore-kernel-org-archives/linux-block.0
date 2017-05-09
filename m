Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35132 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbdEIOL7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 May 2017 10:11:59 -0400
Received: by mail-oi0-f41.google.com with SMTP id l18so799735oig.2
        for <linux-block@vger.kernel.org>; Tue, 09 May 2017 07:11:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVpHHY-XGDtDYCt2wN8w_VPQU5t6E4FMr2S42zN7vyN4w@mail.gmail.com>
References: <149427742346.38205.12361226658239922137.stgit@dwillia2-desk3.amr.corp.intel.com>
 <201705090658.bE7SNvsF%fengguang.wu@intel.com> <CAMuHMdVpHHY-XGDtDYCt2wN8w_VPQU5t6E4FMr2S42zN7vyN4w@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 9 May 2017 07:11:58 -0700
Message-ID: <CAPcyv4giBhFoNPc7h+R-8f7L7tXN_5iVkQs8yZP1mjOn2=JvHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] block, dax: move "select DAX" from BLOCK to FS_DAX
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, May 9, 2017 at 12:57 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Dan,
>
> On Tue, May 9, 2017 at 12:36 AM, kbuild test robot <lkp@intel.com> wrote:
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on next-20170508]
>> [cannot apply to v4.11]
>> [if your patch is applied to the wrong git tree, please drop us a note t=
o help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Dan-Williams/block-dax-=
move-select-DAX-from-BLOCK-to-FS_DAX/20170509-051522
>> config: parisc-c3000_defconfig (attached as .config)
>> compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=3Dparisc
>>
>> All errors (new ones prefixed by >>):
>>
>>    fs/built-in.o: In function `bdev_dax_supported':
>>>> (.text.bdev_dax_supported+0x4c): undefined reference to `dax_get_by_ho=
st'
>>    fs/built-in.o: In function `bdev_dax_supported':
>>>> (.text.bdev_dax_supported+0x5c): undefined reference to `dax_read_lock=
'
>>    fs/built-in.o: In function `bdev_dax_supported':
>>>> (.text.bdev_dax_supported+0x7c): undefined reference to `dax_direct_ac=
cess'
>>    fs/built-in.o: In function `bdev_dax_supported':
>>>> (.text.bdev_dax_supported+0x88): undefined reference to `dax_read_unlo=
ck'
>>    fs/built-in.o: In function `bdev_dax_supported':
>>>> (.text.bdev_dax_supported+0x90): undefined reference to `put_dax'
>
> I ran into the same issue if CONFIG_DAX=3Dm (it's still selected by some =
other
> modular symbol). #if IS_ENABLED(CONFIG_DAX) is true in the modular case, =
so
> the dummies provided by include/linux/dax.h are not used.
>
> However, while changing it to #ifdef CONFIG_DAX allows to build vmlinux, =
it
> leads to other issues as DAX is compiled as a module:
>
>     drivers/dax/super.c:35: error: redefinition of =E2=80=98dax_read_lock=
=E2=80=99
>     include/linux/dax.h:30: error: previous definition of
> =E2=80=98dax_read_lock=E2=80=99 was here
>
> Yes, calling into optional modular code from builtin code in fs/blockdev.=
c is
> tricky ;-(  Perhaps you can make bdev_dax_supported() a small wrapper
> that calls into the real code through a function pointer, when the DAX mo=
dule
> is available?

In fact, that is close to what I did for v2, and it passed a full run
through the kbuild robot. I'll send it out shortly.
