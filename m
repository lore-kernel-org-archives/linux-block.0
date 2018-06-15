Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755675AbeFOJGI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 05:06:08 -0400
Subject: Re: [PATCH v3 05/27] docs: Fix some broken references
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        x86@kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@zh-kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, linux-block@vger.kernel.org,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, linux-bcache@vger.kernel.org,
        linux-usb@vger.kernel.org, devel@driverdev.osuosl.org,
        xen-devel@lists.xenproject.org, cgroups@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <29adfe49571ad1395871a4f72154f45ef361297f.1528990947.git.mchehab+samsung@kernel.org>
From: Coly Li <colyli@suse.de>
Message-ID: <4448f906-39d8-ac44-c116-cd702c4a9096@suse.de>
Date: Fri, 15 Jun 2018 17:05:40 +0800
MIME-Version: 1.0
In-Reply-To: <29adfe49571ad1395871a4f72154f45ef361297f.1528990947.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/6/15 12:08 AM, Mauro Carvalho Chehab wrote:
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
> 	./scripts/documentation-file-ref-check --fix
> 
> Manually checked if the produced result is valid, removing a few
> false-positives.
> 
> Acked-by: Takashi Iwai <tiwai@suse.de>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++--
>  .../bindings/input/rotary-encoder.txt         |  2 +-
>  Documentation/driver-api/gpio/consumer.rst    |  2 +-
>  Documentation/kprobes.txt                     |  4 ++--
>  Documentation/trace/coresight.txt             |  2 +-
>  Documentation/trace/ftrace-uses.rst           |  2 +-
>  Documentation/trace/histogram.txt             |  2 +-
>  Documentation/trace/intel_th.rst              |  2 +-
>  Documentation/trace/tracepoint-analysis.rst   |  6 +++---
>  Documentation/translations/ja_JP/howto.rst    |  4 ++--
>  .../translations/zh_CN/magic-number.txt       |  4 ++--
>  .../zh_CN/video4linux/omap3isp.txt            |  4 ++--
>  MAINTAINERS                                   | 20 +++++++++----------
>  arch/Kconfig                                  |  2 +-
>  arch/arm/include/asm/cacheflush.h             |  2 +-
>  arch/arm64/include/asm/cacheflush.h           |  2 +-
>  arch/microblaze/include/asm/cacheflush.h      |  2 +-
>  arch/um/Kconfig.um                            |  2 +-
>  arch/unicore32/include/asm/cacheflush.h       |  2 +-
>  arch/x86/entry/vsyscall/vsyscall_64.c         |  2 +-
>  arch/xtensa/include/asm/cacheflush.h          |  4 ++--
>  block/Kconfig                                 |  2 +-
>  certs/Kconfig                                 |  2 +-
>  crypto/asymmetric_keys/asymmetric_type.c      |  2 +-
>  crypto/asymmetric_keys/signature.c            |  2 +-
>  drivers/char/Kconfig                          |  2 +-
>  drivers/clk/clk.c                             |  4 ++--
>  drivers/clk/ingenic/cgu.h                     |  2 +-
>  drivers/gpu/vga/Kconfig                       |  2 +-
>  drivers/gpu/vga/vgaarb.c                      |  2 +-
>  drivers/input/joystick/Kconfig                | 10 +++++-----
>  drivers/input/joystick/walkera0701.c          |  2 +-
>  drivers/input/misc/Kconfig                    |  4 ++--
>  drivers/input/misc/rotary_encoder.c           |  2 +-
>  drivers/input/mouse/Kconfig                   |  6 +++---
>  drivers/input/mouse/alps.c                    |  2 +-
>  drivers/input/touchscreen/wm97xx-core.c       |  2 +-
>  drivers/lightnvm/pblk-rb.c                    |  2 +-
>  drivers/md/bcache/Kconfig                     |  2 +-
>  drivers/md/bcache/btree.c                     |  2 +-
>  drivers/md/bcache/extents.c                   |  2 +-
>  drivers/media/dvb-core/dvb_ringbuffer.c       |  2 +-
>  drivers/media/pci/meye/Kconfig                |  2 +-
>  drivers/media/platform/pxa_camera.c           |  4 ++--
>  .../soc_camera/sh_mobile_ceu_camera.c         |  2 +-
>  drivers/media/radio/Kconfig                   |  2 +-
>  drivers/media/radio/si470x/Kconfig            |  2 +-
>  drivers/media/usb/dvb-usb-v2/lmedm04.c        |  2 +-
>  drivers/media/usb/zr364xx/Kconfig             |  2 +-
>  drivers/parport/Kconfig                       |  6 +++---
>  drivers/staging/media/bcm2048/TODO            |  2 +-
>  include/keys/asymmetric-subtype.h             |  2 +-
>  include/keys/asymmetric-type.h                |  2 +-
>  include/linux/assoc_array.h                   |  2 +-
>  include/linux/assoc_array_priv.h              |  2 +-
>  include/linux/circ_buf.h                      |  2 +-
>  include/linux/ftrace.h                        |  2 +-
>  include/linux/rculist_nulls.h                 |  2 +-
>  include/uapi/linux/prctl.h                    |  2 +-
>  include/xen/interface/io/kbdif.h              |  2 +-
>  kernel/cgroup/cpuset.c                        |  2 +-
>  kernel/trace/Kconfig                          | 16 +++++++--------
>  lib/Kconfig                                   |  2 +-
>  security/selinux/hooks.c                      |  2 +-
>  sound/core/Kconfig                            |  4 ++--
>  sound/drivers/Kconfig                         |  4 ++--
>  sound/pci/Kconfig                             | 10 +++++-----
>  tools/include/uapi/linux/prctl.h              |  2 +-
>  tools/lib/api/fs/fs.c                         |  2 +-
>  tools/perf/util/bpf-prologue.c                |  2 +-
>  .../config/custom-timeline-functions.cfg      |  4 ++--
>  71 files changed, 113 insertions(+), 113 deletions(-)

[snip]
> diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
> index 4d200883c505..17bf109c58e9 100644
> --- a/drivers/md/bcache/Kconfig
> +++ b/drivers/md/bcache/Kconfig
> @@ -5,7 +5,7 @@ config BCACHE
>  	Allows a block device to be used as cache for other devices; uses
>  	a btree for indexing and the layout is optimized for SSDs.
>  
> -	See Documentation/bcache.txt for details.
> +	See Documentation/admin-guide/bcache.rst for details.
>  
>  config BCACHE_DEBUG
>  	bool "Bcache debugging"
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 2a0968c04e21..547c9eedc2f4 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -18,7 +18,7 @@
>   * as keys are inserted we only sort the pages that have not yet been written.
>   * When garbage collection is run, we resort the entire node.
>   *
> - * All configuration is done via sysfs; see Documentation/bcache.txt.
> + * All configuration is done via sysfs; see Documentation/admin-guide/bcache.rst.
>   */
>  
>  #include "bcache.h"
> diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
> index c334e6666461..1d096742eb41 100644
> --- a/drivers/md/bcache/extents.c
> +++ b/drivers/md/bcache/extents.c
> @@ -18,7 +18,7 @@
>   * as keys are inserted we only sort the pages that have not yet been written.
>   * When garbage collection is run, we resort the entire node.
>   *
> - * All configuration is done via sysfs; see Documentation/bcache.txt.
> + * All configuration is done via sysfs; see Documentation/admin-guide/bcache.rst.
>   */
>  
>  #include "bcache.h"

For the bcache part, it is good to me.

Reviewed-by: Coly Li <colyli@suse.de>

Thanks for the fix.

Coly Li
