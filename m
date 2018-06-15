Return-Path: <linux-block-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:62087 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966220AbeFOQbp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jun 2018 12:31:45 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@zh-kernel.org,
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
Subject: [PATCH v4 05/26] docs: Fix some broken references
Date: Fri, 15 Jun 2018 13:30:33 -0300
Message-Id: <a018022fcc1080ee10bc8529aaaf46fdb960b086.1529079119.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

As we move stuff around, some doc references are broken. Fix some of
them via this script:
	./scripts/documentation-file-ref-check --fix

Manually checked if the produced result is valid, removing a few
false-positives.

Acked-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++--
 .../bindings/input/rotary-encoder.txt         |  2 +-
 Documentation/driver-api/gpio/consumer.rst    |  2 +-
 Documentation/kprobes.txt                     |  4 ++--
 Documentation/trace/coresight.txt             |  2 +-
 Documentation/trace/ftrace-uses.rst           |  2 +-
 Documentation/trace/histogram.txt             |  2 +-
 Documentation/trace/intel_th.rst              |  2 +-
 Documentation/trace/tracepoint-analysis.rst   |  6 +++---
 Documentation/translations/ja_JP/howto.rst    |  4 ++--
 .../translations/zh_CN/magic-number.txt       |  4 ++--
 .../zh_CN/video4linux/omap3isp.txt            |  4 ++--
 MAINTAINERS                                   | 20 +++++++++----------
 arch/Kconfig                                  |  2 +-
 arch/arm/include/asm/cacheflush.h             |  2 +-
 arch/arm64/include/asm/cacheflush.h           |  2 +-
 arch/microblaze/include/asm/cacheflush.h      |  2 +-
 arch/um/Kconfig.um                            |  2 +-
 arch/unicore32/include/asm/cacheflush.h       |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c         |  2 +-
 arch/xtensa/include/asm/cacheflush.h          |  4 ++--
 block/Kconfig                                 |  2 +-
 certs/Kconfig                                 |  2 +-
 crypto/asymmetric_keys/asymmetric_type.c      |  2 +-
 crypto/asymmetric_keys/signature.c            |  2 +-
 drivers/char/Kconfig                          |  2 +-
 drivers/clk/clk.c                             |  4 ++--
 drivers/clk/ingenic/cgu.h                     |  2 +-
 drivers/gpu/vga/Kconfig                       |  2 +-
 drivers/gpu/vga/vgaarb.c                      |  2 +-
 drivers/input/joystick/Kconfig                | 10 +++++-----
 drivers/input/joystick/walkera0701.c          |  2 +-
 drivers/input/misc/Kconfig                    |  4 ++--
 drivers/input/misc/rotary_encoder.c           |  2 +-
 drivers/input/mouse/Kconfig                   |  6 +++---
 drivers/input/mouse/alps.c                    |  2 +-
 drivers/input/touchscreen/wm97xx-core.c       |  2 +-
 drivers/lightnvm/pblk-rb.c                    |  2 +-
 drivers/md/bcache/Kconfig                     |  2 +-
 drivers/md/bcache/btree.c                     |  2 +-
 drivers/md/bcache/extents.c                   |  2 +-
 drivers/media/dvb-core/dvb_ringbuffer.c       |  2 +-
 drivers/media/pci/meye/Kconfig                |  2 +-
 drivers/media/platform/pxa_camera.c           |  4 ++--
 .../soc_camera/sh_mobile_ceu_camera.c         |  2 +-
 drivers/media/radio/Kconfig                   |  2 +-
 drivers/media/radio/si470x/Kconfig            |  2 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c        |  2 +-
 drivers/media/usb/zr364xx/Kconfig             |  2 +-
 drivers/parport/Kconfig                       |  6 +++---
 drivers/staging/media/bcm2048/TODO            |  2 +-
 include/keys/asymmetric-subtype.h             |  2 +-
 include/keys/asymmetric-type.h                |  2 +-
 include/linux/assoc_array.h                   |  2 +-
 include/linux/assoc_array_priv.h              |  2 +-
 include/linux/circ_buf.h                      |  2 +-
 include/linux/ftrace.h                        |  2 +-
 include/linux/rculist_nulls.h                 |  2 +-
 include/uapi/linux/prctl.h                    |  2 +-
 include/xen/interface/io/kbdif.h              |  2 +-
 kernel/cgroup/cpuset.c                        |  2 +-
 kernel/trace/Kconfig                          | 16 +++++++--------
 lib/Kconfig                                   |  2 +-
 security/selinux/hooks.c                      |  2 +-
 sound/core/Kconfig                            |  4 ++--
 sound/drivers/Kconfig                         |  4 ++--
 sound/pci/Kconfig                             | 10 +++++-----
 tools/include/uapi/linux/prctl.h              |  2 +-
 tools/lib/api/fs/fs.c                         |  2 +-
 tools/perf/util/bpf-prologue.c                |  2 +-
 .../config/custom-timeline-functions.cfg      |  4 ++--
 71 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 638342d0a095..6fa3f31ed2a5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4335,7 +4335,7 @@
 			[FTRACE] Set and start specified trace events in order
 			to facilitate early boot debugging. The event-list is a
 			comma separated list of trace events to enable. See
-			also Documentation/trace/events.txt
+			also Documentation/trace/events.rst
 
 	trace_options=[option-list]
 			[FTRACE] Enable or disable tracer options at boot.
@@ -4350,7 +4350,7 @@
 
 			      trace_options=stacktrace
 
-			See also Documentation/trace/ftrace.txt "trace options"
+			See also Documentation/trace/ftrace.rst "trace options"
 			section.
 
 	tp_printk[FTRACE]
diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index f99fe5cdeaec..a644408b33b8 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -28,7 +28,7 @@ Deprecated properties:
   This property is deprecated. Instead, a 'steps-per-period ' value should
   be used, such as "rotary-encoder,steps-per-period = <2>".
 
-See Documentation/input/rotary-encoder.txt for more information.
+See Documentation/input/devices/rotary-encoder.rst for more information.
 
 Example:
 
diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index c71a50d85b50..aa03f389d41d 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -57,7 +57,7 @@ device that displays digits), an additional index argument can be specified::
 					  enum gpiod_flags flags)
 
 For a more detailed description of the con_id parameter in the DeviceTree case
-see Documentation/gpio/board.txt
+see Documentation/driver-api/gpio/board.rst
 
 The flags parameter is used to optionally specify a direction and initial value
 for the GPIO. Values can be:
diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
index 22208bf2386d..cb3b0de83fc6 100644
--- a/Documentation/kprobes.txt
+++ b/Documentation/kprobes.txt
@@ -724,8 +724,8 @@ migrate your tool to one of the following options:
 
   See following documents:
 
-  - Documentation/trace/kprobetrace.txt
-  - Documentation/trace/events.txt
+  - Documentation/trace/kprobetrace.rst
+  - Documentation/trace/events.rst
   - tools/perf/Documentation/perf-probe.txt
 
 
diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 1d74ad0202b6..efbc832146e7 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -426,5 +426,5 @@ root@genericarmv8:~#
 Details on how to use the generic STM API can be found here [2].
 
 [1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
-[2]. Documentation/trace/stm.txt
+[2]. Documentation/trace/stm.rst
 [3]. https://github.com/Linaro/perf-opencsd
diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index 00283b6dd101..1fbc69894eed 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -199,7 +199,7 @@ If @buf is NULL and reset is set, all functions will be enabled for tracing.
 The @buf can also be a glob expression to enable all functions that
 match a specific pattern.
 
-See Filter Commands in :file:`Documentation/trace/ftrace.txt`.
+See Filter Commands in :file:`Documentation/trace/ftrace.rst`.
 
 To just trace the schedule function:
 
diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
index b13771cb12c1..e73bcf9cb5f3 100644
--- a/Documentation/trace/histogram.txt
+++ b/Documentation/trace/histogram.txt
@@ -7,7 +7,7 @@
 
   Histogram triggers are special event triggers that can be used to
   aggregate trace event data into histograms.  For information on
-  trace events and event triggers, see Documentation/trace/events.txt.
+  trace events and event triggers, see Documentation/trace/events.rst.
 
 
 2. Histogram Trigger Command
diff --git a/Documentation/trace/intel_th.rst b/Documentation/trace/intel_th.rst
index 990f13265178..19e2d633f3c7 100644
--- a/Documentation/trace/intel_th.rst
+++ b/Documentation/trace/intel_th.rst
@@ -38,7 +38,7 @@ description is at Documentation/ABI/testing/sysfs-bus-intel_th-devices-gth.
 
 STH registers an stm class device, through which it provides interface
 to userspace and kernelspace software trace sources. See
-Documentation/trace/stm.txt for more information on that.
+Documentation/trace/stm.rst for more information on that.
 
 MSU can be configured to collect trace data into a system memory
 buffer, which can later on be read from its device nodes via read() or
diff --git a/Documentation/trace/tracepoint-analysis.rst b/Documentation/trace/tracepoint-analysis.rst
index bef37abf4ad3..716326b9f152 100644
--- a/Documentation/trace/tracepoint-analysis.rst
+++ b/Documentation/trace/tracepoint-analysis.rst
@@ -55,7 +55,7 @@ simple case of::
 3.1 System-Wide Event Enabling
 ------------------------------
 
-See Documentation/trace/events.txt for a proper description on how events
+See Documentation/trace/events.rst for a proper description on how events
 can be enabled system-wide. A short example of enabling all events related
 to page allocation would look something like::
 
@@ -112,7 +112,7 @@ at that point.
 3.4 Local Event Enabling
 ------------------------
 
-Documentation/trace/ftrace.txt describes how to enable events on a per-thread
+Documentation/trace/ftrace.rst describes how to enable events on a per-thread
 basis using set_ftrace_pid.
 
 3.5 Local Event Enablement with PCL
@@ -137,7 +137,7 @@ basis using PCL such as follows.
 4. Event Filtering
 ==================
 
-Documentation/trace/ftrace.txt covers in-depth how to filter events in
+Documentation/trace/ftrace.rst covers in-depth how to filter events in
 ftrace.  Obviously using grep and awk of trace_pipe is an option as well
 as any script reading trace_pipe.
 
diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index 8d7ed0cbbf5f..f3116381c26b 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -1,5 +1,5 @@
 NOTE:
-This is a version of Documentation/HOWTO translated into Japanese.
+This is a version of Documentation/process/howto.rst translated into Japanese.
 This document is maintained by Tsugikazu Shibata <tshibata@ab.jp.nec.com>
 If you find any difference between this document and the original file or
 a problem with the translation, please contact the maintainer of this file.
@@ -109,7 +109,7 @@ linux-api@vger.kernel.org に送ることを勧めます。
     ています。 カーネルに関して初めての人はここからスタートすると良い
     でしょう。
 
-  :ref:`Documentation/Process/changes.rst <changes>`
+  :ref:`Documentation/process/changes.rst <changes>`
     このファイルはカーネルをうまく生成(訳注 build )し、走らせるのに最
     小限のレベルで必要な数々のソフトウェアパッケージの一覧を示してい
     ます。
diff --git a/Documentation/translations/zh_CN/magic-number.txt b/Documentation/translations/zh_CN/magic-number.txt
index e9db693c0a23..7159cec04090 100644
--- a/Documentation/translations/zh_CN/magic-number.txt
+++ b/Documentation/translations/zh_CN/magic-number.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/magic-number.txt
+Chinese translated version of Documentation/process/magic-number.rst
 
 If you have any comment or update to the content, please post to LKML directly.
 However, if you have problem communicating in English you can also ask the
@@ -7,7 +7,7 @@ translation is outdated or there is problem with translation.
 
 Chinese maintainer: Jia Wei Wei <harryxiyou@gmail.com>
 ---------------------------------------------------------------------
-Documentation/magic-number.txt的中文翻译
+Documentation/process/magic-number.rst的中文翻译
 
 如果想评论或更新本文的内容，请直接发信到LKML。如果你使用英文交流有困难的话，也可
 以向中文版维护者求助。如果本翻译更新不及时或者翻译存在问题，请联系中文版维护者。
diff --git a/Documentation/translations/zh_CN/video4linux/omap3isp.txt b/Documentation/translations/zh_CN/video4linux/omap3isp.txt
index 67ffbf352ae0..e9f29375aa95 100644
--- a/Documentation/translations/zh_CN/video4linux/omap3isp.txt
+++ b/Documentation/translations/zh_CN/video4linux/omap3isp.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/video4linux/omap3isp.txt
+Chinese translated version of Documentation/media/v4l-drivers/omap3isp.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -11,7 +11,7 @@ Maintainer: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 	  David Cohen <dacohen@gmail.com>
 Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
 ---------------------------------------------------------------------
-Documentation/video4linux/omap3isp.txt 的中文翻译
+Documentation/media/v4l-drivers/omap3isp.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
diff --git a/MAINTAINERS b/MAINTAINERS
index 653a2c29ca43..09554034be46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3079,7 +3079,7 @@ M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 T:	git git://git.alsa-project.org/alsa-kernel.git
 S:	Maintained
-F:	Documentation/sound/alsa/Bt87x.txt
+F:	Documentation/sound/cards/bt87x.rst
 F:	sound/pci/bt87x.c
 
 BT8XXGPIO DRIVER
@@ -3375,7 +3375,7 @@ M:	David Howells <dhowells@redhat.com>
 M:	David Woodhouse <dwmw2@infradead.org>
 L:	keyrings@vger.kernel.org
 S:	Maintained
-F:	Documentation/module-signing.txt
+F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
 F:	scripts/sign-file.c
 F:	scripts/extract-cert.c
@@ -6501,7 +6501,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/hmm*
 F:	include/linux/hmm*
-F:	Documentation/vm/hmm.txt
+F:	Documentation/vm/hmm.rst
 
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
@@ -7401,7 +7401,7 @@ F:	drivers/platform/x86/intel-wmi-thunderbolt.c
 INTEL(R) TRACE HUB
 M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 S:	Supported
-F:	Documentation/trace/intel_th.txt
+F:	Documentation/trace/intel_th.rst
 F:	drivers/hwtracing/intel_th/
 
 INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
@@ -9665,7 +9665,7 @@ F:	include/uapi/linux/mmc/
 MULTIPLEXER SUBSYSTEM
 M:	Peter Rosin <peda@axentia.se>
 S:	Maintained
-F:	Documentation/ABI/testing/mux/sysfs-class-mux*
+F:	Documentation/ABI/testing/sysfs-class-mux*
 F:	Documentation/devicetree/bindings/mux/
 F:	include/linux/dt-bindings/mux/
 F:	include/linux/mux/
@@ -10244,7 +10244,7 @@ F:	arch/powerpc/include/asm/pnv-ocxl.h
 F:	drivers/misc/ocxl/
 F:	include/misc/ocxl*
 F:	include/uapi/misc/ocxl.h
-F:	Documentation/accelerators/ocxl.txt
+F:	Documentation/accelerators/ocxl.rst
 
 OMAP AUDIO SUPPORT
 M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
@@ -13794,7 +13794,7 @@ SYSTEM TRACE MODULE CLASS
 M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git
-F:	Documentation/trace/stm.txt
+F:	Documentation/trace/stm.rst
 F:	drivers/hwtracing/stm/
 F:	include/linux/stm.h
 F:	include/uapi/linux/stm.h
@@ -14471,7 +14471,7 @@ M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Ingo Molnar <mingo@redhat.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 S:	Maintained
-F:	Documentation/trace/ftrace.txt
+F:	Documentation/trace/ftrace.rst
 F:	arch/*/*/*/ftrace.h
 F:	arch/*/kernel/ftrace.c
 F:	include/*/ftrace.h
@@ -14940,7 +14940,7 @@ M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-typec
-F:	Documentation/usb/typec.rst
+F:	Documentation/driver-api/usb/typec.rst
 F:	drivers/usb/typec/
 F:	include/linux/usb/typec.h
 
@@ -15770,7 +15770,7 @@ YEALINK PHONE DRIVER
 M:	Henk Vergonet <Henk.Vergonet@gmail.com>
 L:	usbb2k-api-dev@nongnu.org
 S:	Maintained
-F:	Documentation/input/yealink.rst
+F:	Documentation/input/devices/yealink.rst
 F:	drivers/input/misc/yealink.*
 
 Z8530 DRIVER FOR AX.25
diff --git a/arch/Kconfig b/arch/Kconfig
index 47b235d43909..1aa59063f1fd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -403,7 +403,7 @@ config SECCOMP_FILTER
 	  in terms of Berkeley Packet Filter programs which implement
 	  task-defined system call filtering polices.
 
-	  See Documentation/prctl/seccomp_filter.txt for details.
+	  See Documentation/userspace-api/seccomp_filter.rst for details.
 
 preferred-plugin-hostcc := $(if-success,[ $(gcc-version) -ge 40800 ],$(HOSTCXX),$(HOSTCC))
 
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 869080bedb89..ec1a5fd0d294 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -35,7 +35,7 @@
  *	Start addresses are inclusive and end addresses are exclusive;
  *	start addresses should be rounded down, end addresses up.
  *
- *	See Documentation/cachetlb.txt for more information.
+ *	See Documentation/core-api/cachetlb.rst for more information.
  *	Please note that the implementation of these, and the required
  *	effects are cache-type (VIVT/VIPT/PIPT) specific.
  *
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 0094c6653b06..d264a7274811 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -36,7 +36,7 @@
  *	Start addresses are inclusive and end addresses are exclusive; start
  *	addresses should be rounded down, end addresses up.
  *
- *	See Documentation/cachetlb.txt for more information. Please note that
+ *	See Documentation/core-api/cachetlb.rst for more information. Please note that
  *	the implementation assumes non-aliasing VIPT D-cache and (aliasing)
  *	VIPT I-cache.
  *
diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
index ffea82a16d2c..b091de77b15b 100644
--- a/arch/microblaze/include/asm/cacheflush.h
+++ b/arch/microblaze/include/asm/cacheflush.h
@@ -19,7 +19,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 
-/* Look at Documentation/cachetlb.txt */
+/* Look at Documentation/core-api/cachetlb.rst */
 
 /*
  * Cache handling functions.
diff --git a/arch/um/Kconfig.um b/arch/um/Kconfig.um
index 3e7f228b22e1..20da5a8ca949 100644
--- a/arch/um/Kconfig.um
+++ b/arch/um/Kconfig.um
@@ -80,7 +80,7 @@ config MAGIC_SYSRQ
 	  On UML, this is accomplished by sending a "sysrq" command with
 	  mconsole, followed by the letter for the requested command.
 
-	  The keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
+	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
 	  unless you really know what this hack does.
 
 config KERNEL_STACK_ORDER
diff --git a/arch/unicore32/include/asm/cacheflush.h b/arch/unicore32/include/asm/cacheflush.h
index 1d9132b66039..1c8b9f13a9e1 100644
--- a/arch/unicore32/include/asm/cacheflush.h
+++ b/arch/unicore32/include/asm/cacheflush.h
@@ -33,7 +33,7 @@
  *	Start addresses are inclusive and end addresses are exclusive;
  *	start addresses should be rounded down, end addresses up.
  *
- *	See Documentation/cachetlb.txt for more information.
+ *	See Documentation/core-api/cachetlb.rst for more information.
  *	Please note that the implementation of these, and the required
  *	effects are cache-type (VIVT/VIPT/PIPT) specific.
  *
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 7782cdbcd67d..82ed001e8909 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -201,7 +201,7 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 
 	/*
 	 * Handle seccomp.  regs->ip must be the original value.
-	 * See seccomp_send_sigsys and Documentation/prctl/seccomp_filter.txt.
+	 * See seccomp_send_sigsys and Documentation/userspace-api/seccomp_filter.rst.
 	 *
 	 * We could optimize the seccomp disabled case, but performance
 	 * here doesn't matter.
diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 397d6a1a4224..a0d50be5a8cb 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -88,7 +88,7 @@ static inline void __invalidate_icache_page_alias(unsigned long virt,
  *
  * Pages can get remapped. Because this might change the 'color' of that page,
  * we have to flush the cache before the PTE is changed.
- * (see also Documentation/cachetlb.txt)
+ * (see also Documentation/core-api/cachetlb.rst)
  */
 
 #if defined(CONFIG_MMU) && \
@@ -152,7 +152,7 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 		__invalidate_icache_range(start,(end) - (start));	\
 	} while (0)
 
-/* This is not required, see Documentation/cachetlb.txt */
+/* This is not required, see Documentation/core-api/cachetlb.rst */
 #define	flush_icache_page(vma,page)			do { } while (0)
 
 #define flush_dcache_mmap_lock(mapping)			do { } while (0)
diff --git a/block/Kconfig b/block/Kconfig
index 28ec55752b68..eb50fd4977c2 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -114,7 +114,7 @@ config BLK_DEV_THROTTLING
 	one needs to mount and use blkio cgroup controller for creating
 	cgroups and specifying per device IO rate policies.
 
-	See Documentation/cgroups/blkio-controller.txt for more information.
+	See Documentation/cgroup-v1/blkio-controller.txt for more information.
 
 config BLK_DEV_THROTTLING_LOW
 	bool "Block throttling .low limit interface support (EXPERIMENTAL)"
diff --git a/certs/Kconfig b/certs/Kconfig
index 5f7663df6e8e..c94e93d8bccf 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -13,7 +13,7 @@ config MODULE_SIG_KEY
 
          If this option is unchanged from its default "certs/signing_key.pem",
          then the kernel will automatically generate the private key and
-         certificate as described in Documentation/module-signing.txt
+         certificate as described in Documentation/admin-guide/module-signing.rst
 
 config SYSTEM_TRUSTED_KEYRING
 	bool "Provide system-wide ring of trusted keys"
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 39aecad286fe..26539e9a8bda 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -1,6 +1,6 @@
 /* Asymmetric public-key cryptography key type
  *
- * See Documentation/security/asymmetric-keys.txt
+ * See Documentation/crypto/asymmetric-keys.txt
  *
  * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/crypto/asymmetric_keys/signature.c b/crypto/asymmetric_keys/signature.c
index 11b7ba170904..28198314bc39 100644
--- a/crypto/asymmetric_keys/signature.c
+++ b/crypto/asymmetric_keys/signature.c
@@ -1,6 +1,6 @@
 /* Signature verification with an asymmetric key
  *
- * See Documentation/security/asymmetric-keys.txt
+ * See Documentation/crypto/asymmetric-keys.txt
  *
  * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 410c30c42120..212f447938ae 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -81,7 +81,7 @@ config PRINTER
 	  corresponding drivers into the kernel.
 
 	  To compile this driver as a module, choose M here and read
-	  <file:Documentation/parport.txt>.  The module will be called lp.
+	  <file:Documentation/admin-guide/parport.rst>.  The module will be called lp.
 
 	  If you have several parallel ports, you can specify which ports to
 	  use with the "lp" kernel command line option.  (Try "man bootparam"
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a24a6afb50b6..9760b526ca31 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -6,7 +6,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Standard functionality for the common clock API.  See Documentation/clk.txt
+ * Standard functionality for the common clock API.  See Documentation/driver-api/clk.rst
  */
 
 #include <linux/clk.h>
@@ -2747,7 +2747,7 @@ static int __clk_core_init(struct clk_core *core)
 		goto out;
 	}
 
-	/* check that clk_ops are sane.  See Documentation/clk.txt */
+	/* check that clk_ops are sane.  See Documentation/driver-api/clk.rst */
 	if (core->ops->set_rate &&
 	    !((core->ops->round_rate || core->ops->determine_rate) &&
 	      core->ops->recalc_rate)) {
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 542192376ebf..502bcbb61b04 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -194,7 +194,7 @@ struct ingenic_cgu {
 
 /**
  * struct ingenic_clk - private data for a clock
- * @hw: see Documentation/clk.txt
+ * @hw: see Documentation/driver-api/clk.rst
  * @cgu: a pointer to the CGU data
  * @idx: the index of this clock in cgu->clock_info
  */
diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index 29437eabe095..b677e5d524e6 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -6,7 +6,7 @@ config VGA_ARB
 	  Some "legacy" VGA devices implemented on PCI typically have the same
 	  hard-decoded addresses as they did on ISA. When multiple PCI devices
 	  are accessed at same time they need some kind of coordination. Please
-	  see Documentation/vgaarbiter.txt for more details. Select this to
+	  see Documentation/gpu/vgaarbiter.rst for more details. Select this to
 	  enable VGA arbiter.
 
 config VGA_ARB_MAX_GPUS
diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 1c5e74cb9279..c61b04555779 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -1,6 +1,6 @@
 /*
  * vgaarb.c: Implements the VGA arbitration. For details refer to
- * Documentation/vgaarbiter.txt
+ * Documentation/gpu/vgaarbiter.rst
  *
  *
  * (C) Copyright 2005 Benjamin Herrenschmidt <benh@kernel.crashing.org>
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 32ec4cee6716..d8f9c6e1fc08 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -214,7 +214,7 @@ config JOYSTICK_DB9
 	  gamepad, Sega Saturn gamepad, or a Multisystem -- Atari, Amiga,
 	  Commodore, Amstrad CPC joystick connected to your parallel port.
 	  For more information on how to use the driver please read
-	  <file:Documentation/input/joystick-parport.txt>.
+	  <file:Documentation/input/devices/joystick-parport.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called db9.
@@ -229,7 +229,7 @@ config JOYSTICK_GAMECON
 	  Sony PlayStation gamepad or a Multisystem -- Atari, Amiga,
 	  Commodore, Amstrad CPC joystick connected to your parallel port.
 	  For more information on how to use the driver please read
-	  <file:Documentation/input/joystick-parport.txt>.
+	  <file:Documentation/input/devices/joystick-parport.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called gamecon.
@@ -241,7 +241,7 @@ config JOYSTICK_TURBOGRAFX
 	  Say Y here if you have the TurboGraFX interface by Steffen Schwenke,
 	  and want to use it with Multisystem -- Atari, Amiga, Commodore,
 	  Amstrad CPC joystick. For more information on how to use the driver
-	  please read <file:Documentation/input/joystick-parport.txt>.
+	  please read <file:Documentation/input/devices/joystick-parport.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called turbografx.
@@ -287,7 +287,7 @@ config JOYSTICK_XPAD
 	  and/or "Event interface support" (CONFIG_INPUT_EVDEV) as well.
 
 	  For information about how to connect the X-Box pad to USB, see
-	  <file:Documentation/input/xpad.txt>.
+	  <file:Documentation/input/devices/xpad.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called xpad.
@@ -313,7 +313,7 @@ config JOYSTICK_WALKERA0701
 	  Say Y or M here if you have a Walkera WK-0701 transmitter which is
 	  supplied with a ready to fly Walkera helicopters such as HM36,
 	  HM37, HM60 and want to use it via parport as a joystick. More
-	  information is available: <file:Documentation/input/walkera0701.txt>
+	  information is available: <file:Documentation/input/devices/walkera0701.rst>
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called walkera0701.
diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index 36a5b93156ed..dce313dc260a 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (c) 2008 Peter Popovec
  *
- *  More about driver:  <file:Documentation/input/walkera0701.txt>
+ *  More about driver:  <file:Documentation/input/devices/walkera0701.rst>
  */
 
 /*
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 572b15fa18c2..c25606e00693 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -411,7 +411,7 @@ config INPUT_YEALINK
 	  usb sound driver, so you might want to enable that as well.
 
 	  For information about how to use these additional functions, see
-	  <file:Documentation/input/yealink.txt>.
+	  <file:Documentation/input/devices/yealink.rst>.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called yealink.
@@ -595,7 +595,7 @@ config INPUT_GPIO_ROTARY_ENCODER
 	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say Y here to add support for rotary encoders connected to GPIO lines.
-	  Check file:Documentation/input/rotary-encoder.txt for more
+	  Check file:Documentation/input/devices/rotary-encoder.rst for more
 	  information.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 6d304381fc30..30ec77ad32c6 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -7,7 +7,7 @@
  * state machine code inspired by code from Tim Ruetz
  *
  * A generic driver for rotary encoders connected to GPIO lines.
- * See file:Documentation/input/rotary-encoder.txt for more information
+ * See file:Documentation/input/devices/rotary-encoder.rst for more information
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index f27f23f2d99a..566a1e3aa504 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -129,7 +129,7 @@ config MOUSE_PS2_ELANTECH
 
 	  This driver exposes some configuration registers via sysfs
 	  entries. For further information,
-	  see <file:Documentation/input/elantech.txt>.
+	  see <file:Documentation/input/devices/elantech.rst>.
 
 	  If unsure, say N.
 
@@ -228,7 +228,7 @@ config MOUSE_APPLETOUCH
 	  scrolling in X11.
 
 	  For further information, see
-	  <file:Documentation/input/appletouch.txt>.
+	  <file:Documentation/input/devices/appletouch.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called appletouch.
@@ -251,7 +251,7 @@ config MOUSE_BCM5974
 
 	  The interface is currently identical to the appletouch interface,
 	  for further information, see
-	  <file:Documentation/input/appletouch.txt>.
+	  <file:Documentation/input/devices/appletouch.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm5974.
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index cb5579716dba..0a6f7ca883e7 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -212,7 +212,7 @@ static void alps_set_abs_params_v7(struct alps_data *priv,
 static void alps_set_abs_params_ss4_v2(struct alps_data *priv,
 				       struct input_dev *dev1);
 
-/* Packet formats are described in Documentation/input/alps.txt */
+/* Packet formats are described in Documentation/input/devices/alps.rst */
 
 static bool alps_is_valid_first_byte(struct alps_data *priv,
 				     unsigned char data)
diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index fd714ee881f7..2566b4d8b342 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -68,7 +68,7 @@
  * The default values correspond to Mainstone II in QVGA mode
  *
  * Please read
- * Documentation/input/input-programming.txt for more details.
+ * Documentation/input/input-programming.rst for more details.
  */
 
 static int abs_x[3] = {150, 4000, 5};
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index 00cd1f20a196..55e9442a99e2 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -38,7 +38,7 @@ void pblk_rb_data_free(struct pblk_rb *rb)
 /*
  * Initialize ring buffer. The data and metadata buffers must be previously
  * allocated and their size must be a power of two
- * (Documentation/circular-buffers.txt)
+ * (Documentation/core-api/circular-buffers.rst)
  */
 int pblk_rb_init(struct pblk_rb *rb, struct pblk_rb_entry *rb_entry_base,
 		 unsigned int power_size, unsigned int power_seg_sz)
diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index 4d200883c505..17bf109c58e9 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -5,7 +5,7 @@ config BCACHE
 	Allows a block device to be used as cache for other devices; uses
 	a btree for indexing and the layout is optimized for SSDs.
 
-	See Documentation/bcache.txt for details.
+	See Documentation/admin-guide/bcache.rst for details.
 
 config BCACHE_DEBUG
 	bool "Bcache debugging"
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 2a0968c04e21..547c9eedc2f4 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -18,7 +18,7 @@
  * as keys are inserted we only sort the pages that have not yet been written.
  * When garbage collection is run, we resort the entire node.
  *
- * All configuration is done via sysfs; see Documentation/bcache.txt.
+ * All configuration is done via sysfs; see Documentation/admin-guide/bcache.rst.
  */
 
 #include "bcache.h"
diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index c334e6666461..1d096742eb41 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -18,7 +18,7 @@
  * as keys are inserted we only sort the pages that have not yet been written.
  * When garbage collection is run, we resort the entire node.
  *
- * All configuration is done via sysfs; see Documentation/bcache.txt.
+ * All configuration is done via sysfs; see Documentation/admin-guide/bcache.rst.
  */
 
 #include "bcache.h"
diff --git a/drivers/media/dvb-core/dvb_ringbuffer.c b/drivers/media/dvb-core/dvb_ringbuffer.c
index 4330b6fa4af2..d1d471af0636 100644
--- a/drivers/media/dvb-core/dvb_ringbuffer.c
+++ b/drivers/media/dvb-core/dvb_ringbuffer.c
@@ -55,7 +55,7 @@ int dvb_ringbuffer_empty(struct dvb_ringbuffer *rbuf)
 	 * this pairs with smp_store_release() in dvb_ringbuffer_write(),
 	 * dvb_ringbuffer_write_user(), or dvb_ringbuffer_reset()
 	 *
-	 * for memory barriers also see Documentation/circular-buffers.txt
+	 * for memory barriers also see Documentation/core-api/circular-buffers.rst
 	 */
 	return (rbuf->pread == smp_load_acquire(&rbuf->pwrite));
 }
diff --git a/drivers/media/pci/meye/Kconfig b/drivers/media/pci/meye/Kconfig
index 2e60334ffef5..9a50f54231ad 100644
--- a/drivers/media/pci/meye/Kconfig
+++ b/drivers/media/pci/meye/Kconfig
@@ -5,7 +5,7 @@ config VIDEO_MEYE
 	---help---
 	  This is the video4linux driver for the Motion Eye camera found
 	  in the Vaio Picturebook laptops. Please read the material in
-	  <file:Documentation/video4linux/meye.txt> for more information.
+	  <file:Documentation/media/v4l-drivers/meye.rst> for more information.
 
 	  If you say Y or M here, you need to say Y or M to "Sony Laptop
 	  Extras" in the misc device section.
diff --git a/drivers/media/platform/pxa_camera.c b/drivers/media/platform/pxa_camera.c
index 4d5a26b4cdda..d85ffbfb7c1f 100644
--- a/drivers/media/platform/pxa_camera.c
+++ b/drivers/media/platform/pxa_camera.c
@@ -1021,7 +1021,7 @@ static void pxa_camera_wakeup(struct pxa_camera_dev *pcdev,
  *  - a videobuffer is queued on the pcdev->capture list
  *
  * Please check the "DMA hot chaining timeslice issue" in
- *   Documentation/video4linux/pxa_camera.txt
+ *   Documentation/media/v4l-drivers/pxa_camera.rst
  *
  * Context: should only be called within the dma irq handler
  */
@@ -1443,7 +1443,7 @@ static void pxac_vb2_queue(struct vb2_buffer *vb)
 
 /*
  * Please check the DMA prepared buffer structure in :
- *   Documentation/video4linux/pxa_camera.txt
+ *   Documentation/media/v4l-drivers/pxa_camera.rst
  * Please check also in pxa_camera_check_link_miss() to understand why DMA chain
  * modification while DMA chain is running will work anyway.
  */
diff --git a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
index 242342fd7ede..9897213f2618 100644
--- a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
+++ b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
@@ -1111,7 +1111,7 @@ static void sh_mobile_ceu_put_formats(struct soc_camera_device *icd)
 /*
  * CEU can scale and crop, but we don't want to waste bandwidth and kill the
  * framerate by always requesting the maximum image from the client. See
- * Documentation/video4linux/sh_mobile_ceu_camera.txt for a description of
+ * Documentation/media/v4l-drivers/sh_mobile_ceu_camera.rst for a description of
  * scaling and cropping algorithms and for the meaning of referenced here steps.
  */
 static int sh_mobile_ceu_set_selection(struct soc_camera_device *icd,
diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 39b04ad924c0..b426d6f9787d 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -272,7 +272,7 @@ config RADIO_RTRACK
 	  been reported to be used by these cards.
 
 	  More information is contained in the file
-	  <file:Documentation/video4linux/radiotrack.txt>.
+	  <file:Documentation/media/v4l-drivers/radiotrack.rst>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called radio-aimslab.
diff --git a/drivers/media/radio/si470x/Kconfig b/drivers/media/radio/si470x/Kconfig
index a21172e413a9..6dbb158cd2a0 100644
--- a/drivers/media/radio/si470x/Kconfig
+++ b/drivers/media/radio/si470x/Kconfig
@@ -29,7 +29,7 @@ config USB_SI470X
 
 	  Please have a look at the documentation, especially on how
 	  to redirect the audio stream from the radio to your sound device:
-	  Documentation/video4linux/si470x.txt
+	  Documentation/media/v4l-drivers/si470x.rst
 
 	  Say Y here if you want to connect this type of radio to your
 	  computer's USB port.
diff --git a/drivers/media/usb/dvb-usb-v2/lmedm04.c b/drivers/media/usb/dvb-usb-v2/lmedm04.c
index be26c029546b..39db6dc4b5cd 100644
--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -21,7 +21,7 @@
  *
  * LME2510C + M88RS2000
  *
- * For firmware see Documentation/dvb/lmedm04.txt
+ * For firmware see Documentation/media/dvb-drivers/lmedm04.rst
  *
  * I2C addresses:
  * 0xd0 - STV0288	- Demodulator
diff --git a/drivers/media/usb/zr364xx/Kconfig b/drivers/media/usb/zr364xx/Kconfig
index 0f585662881d..ac429bca70e8 100644
--- a/drivers/media/usb/zr364xx/Kconfig
+++ b/drivers/media/usb/zr364xx/Kconfig
@@ -6,7 +6,7 @@ config USB_ZR364XX
 	---help---
 	  Say Y here if you want to connect this type of camera to your
 	  computer's USB port.
-	  See <file:Documentation/video4linux/zr364xx.txt> for more info
+	  See <file:Documentation/media/v4l-drivers/zr364xx.rst> for more info
 	  and list of supported cameras.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index 44333bd8f908..a97f4eada60b 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -20,7 +20,7 @@ menuconfig PARPORT
 	  drive, PLIP link (Parallel Line Internet Protocol is mainly used to
 	  create a mini network by connecting the parallel ports of two local
 	  machines) etc., then you need to say Y here; please read
-	  <file:Documentation/parport.txt> and
+	  <file:Documentation/admin-guide/parport.rst> and
 	  <file:drivers/parport/BUGS-parport>.
 
 	  For extensive information about drivers for many devices attaching
@@ -33,7 +33,7 @@ menuconfig PARPORT
 	  the module will be called parport.
 	  If you have more than one parallel port and want to specify which
 	  port and IRQ to be used by this driver at module load time, take a
-	  look at <file:Documentation/parport.txt>.
+	  look at <file:Documentation/admin-guide/parport.rst>.
 
 	  If unsure, say Y.
 
@@ -71,7 +71,7 @@ config PARPORT_PC_FIFO
 	  As well as actually having a FIFO, or DMA capability, the kernel
 	  will need to know which IRQ the parallel port has.  By default,
 	  parallel port interrupts will not be used, and so neither will the
-	  FIFO.  See <file:Documentation/parport.txt> to find out how to
+	  FIFO.  See <file:Documentation/admin-guide/parport.rst> to find out how to
 	  specify which IRQ/DMA to use.
 
 config PARPORT_PC_SUPERIO
diff --git a/drivers/staging/media/bcm2048/TODO b/drivers/staging/media/bcm2048/TODO
index 051f85dbe89e..6bee2a2dad68 100644
--- a/drivers/staging/media/bcm2048/TODO
+++ b/drivers/staging/media/bcm2048/TODO
@@ -3,7 +3,7 @@ TODO:
 From the initial code review:
 
 The main thing you need to do is to implement all the controls using the
-control framework (see Documentation/video4linux/v4l2-controls.txt).
+control framework (see Documentation/media/kapi/v4l2-controls.rst).
 Most drivers are by now converted to the control framework, so you will
 find many examples of how to do this in drivers/media/radio.
 
diff --git a/include/keys/asymmetric-subtype.h b/include/keys/asymmetric-subtype.h
index 2480469ce8fb..e0a9c2368872 100644
--- a/include/keys/asymmetric-subtype.h
+++ b/include/keys/asymmetric-subtype.h
@@ -1,6 +1,6 @@
 /* Asymmetric public-key cryptography key subtype
  *
- * See Documentation/security/asymmetric-keys.txt
+ * See Documentation/crypto/asymmetric-keys.txt
  *
  * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index b38240716d41..1cb77cd5135e 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -1,6 +1,6 @@
 /* Asymmetric Public-key cryptography key type interface
  *
- * See Documentation/security/asymmetric-keys.txt
+ * See Documentation/crypto/asymmetric-keys.txt
  *
  * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/linux/assoc_array.h b/include/linux/assoc_array.h
index a89df3be1686..65e3832f96b2 100644
--- a/include/linux/assoc_array.h
+++ b/include/linux/assoc_array.h
@@ -1,6 +1,6 @@
 /* Generic associative array implementation.
  *
- * See Documentation/assoc_array.txt for information.
+ * See Documentation/core-api/assoc_array.rst for information.
  *
  * Copyright (C) 2013 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/linux/assoc_array_priv.h b/include/linux/assoc_array_priv.h
index 711275e6681c..a00a06550c10 100644
--- a/include/linux/assoc_array_priv.h
+++ b/include/linux/assoc_array_priv.h
@@ -1,6 +1,6 @@
 /* Private definitions for the generic associative array implementation.
  *
- * See Documentation/assoc_array.txt for information.
+ * See Documentation/core-api/assoc_array.rst for information.
  *
  * Copyright (C) 2013 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
diff --git a/include/linux/circ_buf.h b/include/linux/circ_buf.h
index 7cf262a421c3..b3233e8202f9 100644
--- a/include/linux/circ_buf.h
+++ b/include/linux/circ_buf.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * See Documentation/circular-buffers.txt for more information.
+ * See Documentation/core-api/circular-buffers.rst for more information.
  */
 
 #ifndef _LINUX_CIRC_BUF_H
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9c3c9a319e48..8154f4920fcb 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Ftrace header.  For implementation details beyond the random comments
- * scattered below, see: Documentation/trace/ftrace-design.txt
+ * scattered below, see: Documentation/trace/ftrace-design.rst
  */
 
 #ifndef _LINUX_FTRACE_H
diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index e4b257ff881b..bc8206a8f30e 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -109,7 +109,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
  *
  * The barrier() is needed to make sure compiler doesn't cache first element [1],
  * as this loop can be restarted [2]
- * [1] Documentation/atomic_ops.txt around line 114
+ * [1] Documentation/core-api/atomic_ops.rst around line 114
  * [2] Documentation/RCU/rculist_nulls.txt around line 146
  */
 #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)			\
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index db9f15f5db04..c0d7ea0bf5b6 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -170,7 +170,7 @@ struct prctl_mm_map {
  * asking selinux for a specific new context (e.g. with runcon) will result
  * in execve returning -EPERM.
  *
- * See Documentation/prctl/no_new_privs.txt for more details.
+ * See Documentation/userspace-api/no_new_privs.rst for more details.
  */
 #define PR_SET_NO_NEW_PRIVS	38
 #define PR_GET_NO_NEW_PRIVS	39
diff --git a/include/xen/interface/io/kbdif.h b/include/xen/interface/io/kbdif.h
index 2a9510ade701..e2340a4130cf 100644
--- a/include/xen/interface/io/kbdif.h
+++ b/include/xen/interface/io/kbdif.h
@@ -317,7 +317,7 @@ struct xenkbd_position {
  * Linux [2] and Windows [3] multi-touch support.
  *
  * [1] https://cgit.freedesktop.org/wayland/wayland/tree/protocol/wayland.xml
- * [2] https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt
+ * [2] https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.rst
  * [3] https://msdn.microsoft.com/en-us/library/jj151564(v=vs.85).aspx
  *
  *
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d8b12e0d39cd..266f10cb7222 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -605,7 +605,7 @@ static inline int nr_cpusets(void)
  * load balancing domains (sched domains) as specified by that partial
  * partition.
  *
- * See "What is sched_load_balance" in Documentation/cgroups/cpusets.txt
+ * See "What is sched_load_balance" in Documentation/cgroup-v1/cpusets.txt
  * for a background explanation of this.
  *
  * Does not return errors, on the theory that the callers of this
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index dd6c0a2ad969..dcc0166d1997 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -12,22 +12,22 @@ config NOP_TRACER
 config HAVE_FTRACE_NMI_ENTER
 	bool
 	help
-	  See Documentation/trace/ftrace-design.txt
+	  See Documentation/trace/ftrace-design.rst
 
 config HAVE_FUNCTION_TRACER
 	bool
 	help
-	  See Documentation/trace/ftrace-design.txt
+	  See Documentation/trace/ftrace-design.rst
 
 config HAVE_FUNCTION_GRAPH_TRACER
 	bool
 	help
-	  See Documentation/trace/ftrace-design.txt
+	  See Documentation/trace/ftrace-design.rst
 
 config HAVE_DYNAMIC_FTRACE
 	bool
 	help
-	  See Documentation/trace/ftrace-design.txt
+	  See Documentation/trace/ftrace-design.rst
 
 config HAVE_DYNAMIC_FTRACE_WITH_REGS
 	bool
@@ -35,12 +35,12 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
-	  See Documentation/trace/ftrace-design.txt
+	  See Documentation/trace/ftrace-design.rst
 
 config HAVE_SYSCALL_TRACEPOINTS
 	bool
 	help
-	  See Documentation/trace/ftrace-design.txt
+	  See Documentation/trace/ftrace-design.rst
 
 config HAVE_FENTRY
 	bool
@@ -448,7 +448,7 @@ config KPROBE_EVENTS
 	help
 	  This allows the user to add tracing events (similar to tracepoints)
 	  on the fly via the ftrace interface. See
-	  Documentation/trace/kprobetrace.txt for more details.
+	  Documentation/trace/kprobetrace.rst for more details.
 
 	  Those events can be inserted wherever kprobes can probe, and record
 	  various register and memory values.
@@ -575,7 +575,7 @@ config MMIOTRACE
 	  implementation and works via page faults. Tracing is disabled by
 	  default and can be enabled at run-time.
 
-	  See Documentation/trace/mmiotrace.txt.
+	  See Documentation/trace/mmiotrace.rst.
 	  If you are not helping to develop drivers, say N.
 
 config TRACING_MAP
diff --git a/lib/Kconfig b/lib/Kconfig
index 809fdd155739..e34b04b56057 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -405,7 +405,7 @@ config ASSOCIATIVE_ARRAY
 
 	  See:
 
-		Documentation/assoc_array.txt
+		Documentation/core-api/assoc_array.rst
 
 	  for more information.
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9a46dc24ac10..2b5ee5fbd652 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4728,7 +4728,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 }
 
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
- * and sctp_sendmsg(3) as described in Documentation/security/LSM-sctp.txt
+ * and sctp_sendmsg(3) as described in Documentation/security/LSM-sctp.rst
  */
 static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 6e937a8146a1..63b3ef9c83f5 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -48,7 +48,7 @@ config SND_MIXER_OSS
 	depends on SND_OSSEMUL
 	help
 	  To enable OSS mixer API emulation (/dev/mixer*), say Y here
-	  and read <file:Documentation/sound/alsa/OSS-Emulation.txt>.
+	  and read <file:Documentation/sound/designs/oss-emulation.rst>.
 
 	  Many programs still use the OSS API, so say Y.
 
@@ -61,7 +61,7 @@ config SND_PCM_OSS
 	select SND_PCM
 	help
 	  To enable OSS digital audio (PCM) emulation (/dev/dsp*), say Y
-	  here and read <file:Documentation/sound/alsa/OSS-Emulation.txt>.
+	  here and read <file:Documentation/sound/designs/oss-emulation.rst>.
 
 	  Many programs still use the OSS API, so say Y.
 
diff --git a/sound/drivers/Kconfig b/sound/drivers/Kconfig
index 7144cc36e8ae..648a12da44f9 100644
--- a/sound/drivers/Kconfig
+++ b/sound/drivers/Kconfig
@@ -153,7 +153,7 @@ config SND_SERIAL_U16550
 	select SND_RAWMIDI
 	help
 	  To include support for MIDI serial port interfaces, say Y here
-	  and read <file:Documentation/sound/alsa/serial-u16550.txt>.
+	  and read <file:Documentation/sound/cards/serial-u16550.rst>.
 	  This driver works with serial UARTs 16550 and better.
 
 	  This driver accesses the serial port hardware directly, so
@@ -223,7 +223,7 @@ config SND_AC97_POWER_SAVE
 	  the device frequently.  A value of 10 seconds would be a
 	  good choice for normal operations.
 
-	  See Documentation/sound/alsa/powersave.txt for more details.
+	  See Documentation/sound/designs/powersave.rst for more details.
 
 config SND_AC97_POWER_SAVE_DEFAULT
 	int "Default time-out for AC97 power-save mode"
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index d9f3fdb777e4..4105d9f653d9 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -175,7 +175,7 @@ config SND_BT87X
 	help
 	  If you want to record audio from TV cards based on
 	  Brooktree Bt878/Bt879 chips, say Y here and read
-	  <file:Documentation/sound/alsa/Bt87x.txt>.
+	  <file:Documentation/sound/cards/bt87x.rst>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-bt87x.
@@ -210,7 +210,7 @@ config SND_CMIPCI
 	help
 	  If you want to use soundcards based on C-Media CMI8338, CMI8738,
 	  CMI8768 or CMI8770 chips, say Y here and read
-	  <file:Documentation/sound/alsa/CMIPCI.txt>.
+	  <file:Documentation/sound/cards/cmipci.rst>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-cmipci.
@@ -472,8 +472,8 @@ config SND_EMU10K1
 	  Audigy and E-mu APS (partially supported) soundcards.
 
 	  The confusing multitude of mixer controls is documented in
-	  <file:Documentation/sound/alsa/SB-Live-mixer.txt> and
-	  <file:Documentation/sound/alsa/Audigy-mixer.txt>.
+	  <file:Documentation/sound/cards/sb-live-mixer.rst> and
+	  <file:Documentation/sound/cards/audigy-mixer.rst>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-emu10k1.
@@ -735,7 +735,7 @@ config SND_MIXART
 	select SND_PCM
 	help
 	  If you want to use Digigram miXart soundcards, say Y here and
-	  read <file:Documentation/sound/alsa/MIXART.txt>.
+	  read <file:Documentation/sound/cards/mixart.rst>.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-mixart.
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index db9f15f5db04..c0d7ea0bf5b6 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -170,7 +170,7 @@ struct prctl_mm_map {
  * asking selinux for a specific new context (e.g. with runcon) will result
  * in execve returning -EPERM.
  *
- * See Documentation/prctl/no_new_privs.txt for more details.
+ * See Documentation/userspace-api/no_new_privs.rst for more details.
  */
 #define PR_SET_NO_NEW_PRIVS	38
 #define PR_GET_NO_NEW_PRIVS	39
diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 6a12bbf39f7b..7aba8243a0e7 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -201,7 +201,7 @@ static void mem_toupper(char *f, size_t len)
 
 /*
  * Check for "NAME_PATH" environment variable to override fs location (for
- * testing). This matches the recommendation in Documentation/sysfs-rules.txt
+ * testing). This matches the recommendation in Documentation/admin-guide/sysfs-rules.rst
  * for SYSFS_PATH.
  */
 static bool fs__env_override(struct fs *fs)
diff --git a/tools/perf/util/bpf-prologue.c b/tools/perf/util/bpf-prologue.c
index 29347756b0af..77e4891e17b0 100644
--- a/tools/perf/util/bpf-prologue.c
+++ b/tools/perf/util/bpf-prologue.c
@@ -61,7 +61,7 @@ check_pos(struct bpf_insn_pos *pos)
 
 /*
  * Convert type string (u8/u16/u32/u64/s8/s16/s32/s64 ..., see
- * Documentation/trace/kprobetrace.txt) to size field of BPF_LDX_MEM
+ * Documentation/trace/kprobetrace.rst) to size field of BPF_LDX_MEM
  * instruction (BPF_{B,H,W,DW}).
  */
 static int
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
index 4f80ad7d7275..f8fcb06fd68b 100644
--- a/tools/power/pm-graph/config/custom-timeline-functions.cfg
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -105,7 +105,7 @@ override-dev-timeline-functions: true
 #       example: [color=#CC00CC]
 #
 #   arglist: A list of arguments from registers/stack addresses. See URL:
-#            https://www.kernel.org/doc/Documentation/trace/kprobetrace.txt
+#            https://www.kernel.org/doc/Documentation/trace/kprobetrace.rst
 #
 #       example: cpu=%di:s32
 #
@@ -170,7 +170,7 @@ pm_restore_console:
 #       example: [color=#CC00CC]
 #
 #   arglist: A list of arguments from registers/stack addresses. See URL:
-#            https://www.kernel.org/doc/Documentation/trace/kprobetrace.txt
+#            https://www.kernel.org/doc/Documentation/trace/kprobetrace.rst
 #
 #       example: port=+36(%di):s32
 #
-- 
2.17.1
