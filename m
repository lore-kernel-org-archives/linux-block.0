Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gateway23.websitewelcome.com ([192.185.50.250]:47035 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754642AbcKIRXV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Nov 2016 12:23:21 -0500
Received: from cm2.websitewelcome.com (cm2.websitewelcome.com [192.185.178.13])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 51077457EBB7
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2016 11:23:13 -0600 (CST)
Date: Wed, 9 Nov 2016 10:23:08 -0700
From: Stephen Bates <sbates@raithlin.com>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        ckulkarnilinux@gmail.com
Subject: Re: [PATCH] Unittest framework based on nvme-cli.
Message-ID: <20161109172308.GA9948@cgy1-donard.priv.deltatee.com>
Reply-To: 1477980073-14715-1-git-send-email-chaitanya.kulkarni@hgst.com
MIME-Version: 1.0
Content-Type: text/x-diff; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Hi Chaitanya

Thanks for doing this work. A simple test framework that builds on top
of nvme-cli is a very good idea. My comments are below.

Cheers

Stephen

>From 38de47d65b855f4dc361147f673a9b3721768e2d Mon Sep 17 00:00:00 2001
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Date: Wed, 26 Oct 2016 12:55:21 -0700
Subject: [PATCH] Unittest framework based on nvme-cli.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
---
 Makefile                            |   5 +-
 tests/Makefile                      |  48 +++++
 tests/README                        |  84 ++++++++
 tests/TODO                          |  14 ++
 tests/config.json                   |   5 +
 tests/nvme_attach_detach_ns_test.py |  90 ++++++++
 tests/nvme_compare_test.py          |  79 ++++++++
 tests/nvme_create_max_ns_test.py    |  97 +++++++++
 tests/nvme_error_log_test.py        |  86 ++++++++
 tests/nvme_flush_test.py            |  61 ++++++
 tests/nvme_format_test.py           | 145 +++++++++++++
 tests/nvme_get_features_test.py     | 103 ++++++++++
 tests/nvme_read_write_test.py       |  72 +++++++
 tests/nvme_simple_template_test.py  |  55 +++++
 tests/nvme_smart_log_test.py        |  86 ++++++++
 tests/nvme_test.py                  | 395 ++++++++++++++++++++++++++++++++++++
 tests/nvme_test_io.py               |  99 +++++++++
 tests/nvme_test_logger.py           |  52 +++++
 tests/nvme_writeuncor_test.py       |  76 +++++++
 tests/nvme_writezeros_test.py       | 102 ++++++++++
 20 files changed, 1753 insertions(+), 1 deletion(-)
 create mode 100644 tests/Makefile
 create mode 100644 tests/README
 create mode 100644 tests/TODO
 create mode 100644 tests/config.json
 create mode 100644 tests/nvme_attach_detach_ns_test.py
 create mode 100644 tests/nvme_compare_test.py
 create mode 100644 tests/nvme_create_max_ns_test.py
 create mode 100644 tests/nvme_error_log_test.py
 create mode 100644 tests/nvme_flush_test.py
 create mode 100644 tests/nvme_format_test.py
 create mode 100644 tests/nvme_get_features_test.py
 create mode 100644 tests/nvme_read_write_test.py
 create mode 100644 tests/nvme_simple_template_test.py
 create mode 100644 tests/nvme_smart_log_test.py
 create mode 100644 tests/nvme_test.py
 create mode 100644 tests/nvme_test_io.py
 create mode 100644 tests/nvme_test_logger.py
 create mode 100644 tests/nvme_writeuncor_test.py
 create mode 100644 tests/nvme_writezeros_test.py

diff --git a/Makefile b/Makefile
index 117cbbe..33c7190 100644
--- a/Makefile
+++ b/Makefile
@@ -46,6 +46,9 @@ nvme.o: nvme.c nvme.h nvme-print.h nvme-ioctl.h argconfig.h suffix.h nvme-lightn
 doc: $(NVME)
 	$(MAKE) -C Documentation

+test:
+	$(MAKE) -C tests/ run
+
 all: doc

 clean:
@@ -136,4 +139,4 @@ rpm: dist
 	$(RPMBUILD) -ta nvme-$(NVME_VERSION).tar.gz

 .PHONY: default doc all clean clobber install-man install-bin install
-.PHONY: dist pkg dist-orig deb deb-light rpm FORCE
+.PHONY: dist pkg dist-orig deb deb-light rpm FORCE test
diff --git a/tests/Makefile b/tests/Makefile
new file mode 100644
index 0000000..c0f9f31
--- /dev/null
+++ b/tests/Makefile
@@ -0,0 +1,48 @@
+###############################################################################
+#
+#    Makefile : Allows user to run testcases, generate documentation, and
+#               perform static code analysis.
+#
+###############################################################################
+
+NOSE2_OPTIONS="--verbose"
+
+help: all
+
+all:
+	@echo "Usage:"
+	@echo
+	@echo "  make run         - Run all testcases."
+	@echo "  make doc         - Generate Documentation."
+	@echo "  make cleanall    - removes *pyc, documentation."
+	@echo "  make static_check- runs pep8, flake8, pylint on code."
+

Do you really want make all to just dump the help message?

+doc:
+	@epydoc -v --output=Documentation *.py

Do you list out epydoc in the dependency list in the documentation?

+
+run:
+	@for i in `ls *.py`; \
+	do \
+		echo "Running $${i}"; \
+		TESTCASE_NAME=`echo $${i} | cut -f 1 -d '.'`; \
+		nose2 ${NOSE2_OPTIONS} $${TESTCASE_NAME}; \
+	done
+
+static_check:
+	@for i in `ls *.py`; \
+	do \
+		echo "Pylint :- " ; \
+		printf "%10s    " $${i}; \
+		pylint $${i} 2>&1  | grep "^Your code" |  awk '{print $$7}';\
+		echo "--------------------------------------------";\
+		pep8 $${i}; \
+		echo "pep8 :- "; \
+		echo "flake8 :- "; \
+		flake8 $${i}; \
+	done
+
+cleanall: clean
+	@rm -fr *.pyc Documentation
+
+clean:
+	@rm -fr *.pyc
diff --git a/tests/README b/tests/README
new file mode 100644
index 0000000..70686d8
--- /dev/null
+++ b/tests/README
@@ -0,0 +1,84 @@
+nvmetests
+=========
+
+    This contains NVMe unit tests framework. The purpose of this framework
+    to use nvme cli and test various supported commands and scenarios for
+    NVMe device.
+
+    In current implementation this framework uses nvme cli to
+    interact with underlying controller/namespace.
+
+1. Common Package Dependencies
+------------------------------
+
+    1. Python(>= 2.7.5 or >= 3.3)
+    2. nose2(Installation guide http://nose2.readthedocs.io/)
+    3. nvme-cli(https://github.com/linux-nvme/nvme-cli.git)
+
+2. Overview
+-----------
+
+    This framework follows simple class hierarchy. Each test file contains
+    one test. Each test is direct subclass or indirect subclass of TestNVMe
+    class which represents one testcase. To write a new testcase one can copy
+    existing template "nvme_simple_template_test.py" and start adding new
+    testcase specific functionality. For detailed information please look into
+    section 3.
+
+    For more information about tests, class hierarchy and code please refer :-
+
+    1. Documentation :- html/
+    2. Class Index :-  html/index.html
+    3. Class Hierarchy :- html/class-tree.html
+
+    For each testcase it will create log directory mentioned in
+    configuration file. This directory will be used for a temporary files
+    and storing execution logs of each testcases. Current implementation stores
+    stdout and stderr for each testcase under log directory, e.g. :-
+
+        $ tree nvmetests/
+        nvmetests/
+        ├── TestNVMeAttachDetachNSCmd
+        │   ├── stderr.log
+        │   └── stdout.log
+        ├── TestNVMeFlushCmd
+        │   ├── stderr.log
+        │   └── stdout.log
+        └── TestNVMeFormatCmd
+            ├── stderr.log
+            └── stdout.log
+

You seem to have some odd ASCII characters in the above?

+                 .
+                 .
+                 .
+
+3. Walk-Through Example for writing a new testcase
+--------------------------------------------------
+    1. Copy simple test template file from current directory
+       with appropriate name, replace "simple_template" with testcase name
+       in new file name. Update config.json if necessary.
+    2. Write a testcase main function, make sure its name is starting with
+       test_*.
+    3. Based on the requirement one can inherit TestNVMe or TestNVMeIO
+       class.
+    4. Write test precondition code into __init__. Make sure you are calling
+       super class __init__.
+    5. Write test post condition code into __del__. Make sure you are calling
+       super class __del__.
+    6. Before writing a new function have a look into TestNVMe to see if it
+       can be reused.
+    7. Once testcase is ready make sure :-
+           a. Run pep8, flake8, pylint on the testcase and fix errors/warnings.
+              -Example "$ make static_check" will run pep8, flake8 and pylint on
+              all the python files in current directory.
+           b. Execute make doc to generate the documentation.
+              -Example "$ make doc" will create and update existing
+              documentation.
+
+4. Running testcases with framework
+-----------------------------------
+    1. Running single testcase with nose2 :-
+       $ nose2 --verbose nvme_writezeros_test
+       $ nose2 --verbose nvme_read_write_test
+
+    2. Running all the testcases with Makefile :-
+       $ make run
diff --git a/tests/TODO b/tests/TODO
new file mode 100644
index 0000000..69806a9
--- /dev/null
+++ b/tests/TODO
@@ -0,0 +1,14 @@
+nvmetests TODO List
+===================
+
+Feature list (with priority):-
+------------------------------
+    1. PRE and POST section improvements :-
+        a. Add functionality to load and unload driver.
+        b. Make sure default namespace is present, if not create one before
+           any test begins. Read the default namespace size from config file.
+    2. Add system statistics collection in PRE and POST section of testcase.
+    3. Create execution summary file under log directory at the end of each
+       run.
+    4. Add tracing functionality to track overall and current progress of the
+       testcase.
diff --git a/tests/config.json b/tests/config.json
new file mode 100644
index 0000000..098fba8
--- /dev/null
+++ b/tests/config.json
@@ -0,0 +1,5 @@
+{
+	"controller" : "/dev/nvme0",
+        "ns1": "/dev/nvme0n1",

whitespace damage above.

+	"log_dir": "nvmetests/"
+}
diff --git a/tests/nvme_attach_detach_ns_test.py b/tests/nvme_attach_detach_ns_test.py
new file mode 100644
index 0000000..92a82dd
--- /dev/null
+++ b/tests/nvme_attach_detach_ns_test.py
@@ -0,0 +1,90 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Namespace Management Testcase:-
+
+    1. Create Namespace and validate.
+    2. Attach Namespace to controller.
+    3. Run IOs on Namespace under test.
+    4. Detach Namespace from controller.
+    5. Delete Namespace.
+"""
+
+import time
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+
+
+class TestNVMeAttachDetachNSCmd(TestNVMe):
+
+    """
+    Represents Attach, Detach namespace testcase.
+
+        - Attributes:
+              - dps : data protection information.
+              - flabs : LBA format information.
+              - nsze : namespace size.
+              - ncap : namespace capacity.
+              - ctrl_id : controller id.
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeAttachDetachNSCmd """
+        TestNVMe.__init__(self)
+        self.dps = 0
+        self.flbas = 0
+        self.nsze = 0x1400000
+        self.ncap = 0x1400000
+        self.setup_log_dir(self.__class__.__name__)
+        self.ctrl_id = self.get_ctrl_id()
+        self.delete_all_ns()
+        time.sleep(1)
+
+    def __del__(self):
+        """
+        Post Section for TestNVMeAttachDetachNSCmd
+
+            - Create primary namespace.
+            - Atttach it to controller.
+            - Call super class's destructor.
+        """
+        assert_equal(self.create_and_validate_ns(self.default_nsid,
+                                                 self.nsze,
+                                                 self.ncap,
+                                                 self.flbas,
+                                                 self.dps), 0)
+        self.attach_ns(self.ctrl_id, self.default_nsid)
+        TestNVMe.__del__(self)
+
+    def test_attach_detach_ns(self):
+        """ Testcase main """
+        err = self.create_and_validate_ns(self.default_nsid,
+                                          self.nsze,
+                                          self.ncap,
+                                          self.flbas,
+                                          self.dps)
+        assert_equal(err, 0)
+        assert_equal(self.attach_ns(self.ctrl_id, self.default_nsid), 0)
+
+        self.run_ns_io(self.default_nsid, 0)
+
+        assert_equal(self.detach_ns(self.ctrl_id, self.default_nsid), 0)
+        assert_equal(self.delete_and_validate_ns(self.default_nsid), 0)
+        self.nvme_reset_ctrl()
diff --git a/tests/nvme_compare_test.py b/tests/nvme_compare_test.py
new file mode 100644
index 0000000..34c140d
--- /dev/null
+++ b/tests/nvme_compare_test.py
@@ -0,0 +1,79 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Compare Command Testcase:-
+
+    1. Create a data file 1 with pattern 1515 to write.
+    2. Create a data file 2 with pattern 2525 to compare with.
+    3. Write a block of data pattern using data file1.
+    4. Compare written block to data file 2's pattern; shall fail.
+    5. Compare written block to data file1's pattern; shall pass.
+
+"""
+
+from nose.tools import assert_equal, assert_not_equal
+from nvme_test_io import TestNVMeIO
+
+
+class TestNVMeCompareCmd(TestNVMeIO):
+
+    """
+    Represents Compare Testcase. Inherits TestNVMeIO class.
+
+        - Attributes:
+              - data_size : data size to perform IO.
+              - start_block : starting block of to perform IO.
+              - compare_file : data file to use in nvme comapre commmand.
+              - test_log_dir : directory for logs, temp files.
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeCompareCmd """
+        TestNVMeIO.__init__(self)
+        self.data_size = 1024
+        self.start_block = 1023
+        self.setup_log_dir(self.__class__.__name__)
+        self.compare_file = self.test_log_dir + "/" + "compare_file.txt"
+        self.write_file = self.test_log_dir + "/" + self.write_file
+        self.create_data_file(self.write_file, self.data_size, "15")
+        self.create_data_file(self.compare_file, self.data_size, "25")
+
+    def __del__(self):
+        """ Post Section for TestNVMeCompareCmd """
+        TestNVMeIO.__del__(self)
+
+    def nvme_compare(self, cmp_file):
+        """ Wrapper for nvme compare command.
+           - Args:
+               - cmp_file : data file used in nvme compare command.
+           - Returns:
+               - return code of the nvme compare command.
+        """
+        compare_cmd = "nvme compare " + self.ns1 + " --start-block=" + \
+                      str(self.start_block) + " --block-count=" + \
+                      str(self.block_count) + " --data-size=" + \
+                      str(self.data_size) + " --data=" + cmp_file
+        return self.exec_cmd(compare_cmd)
+
+    def test_nvme_compare(self):
+        """ Testcase main """
+        assert_equal(self.nvme_write(), 0)
+        assert_not_equal(self.nvme_compare(self.compare_file), 0)
+        assert_equal(self.nvme_compare(self.write_file), 0)
diff --git a/tests/nvme_create_max_ns_test.py b/tests/nvme_create_max_ns_test.py
new file mode 100644
index 0000000..15e0770
--- /dev/null
+++ b/tests/nvme_create_max_ns_test.py
@@ -0,0 +1,97 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Namespace Management Testcase:-
+
+    1. Create Maximum number of Namespaces and validate.
+    2. Attach all Namespaces to controller.
+    3. Run IOs on Namespace under test.
+    4. Detach Maximum number of Namespaces from controller.
+    5. Delete all Namespaces.
+"""
+
+import time
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+
+
+class TestNVMeCreateMaxNS(TestNVMe):
+
+    """
+    Represents Attach, Detach namespace testcase.
+
+        - Attributes:
+              - dps : data protection information.
+              - flabs : LBA format information.
+              - nsze : namespace size.
+              - ncap : namespace capacity.
+              - ctrl_id : controller id.
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeAttachDetachNSCmd """
+        TestNVMe.__init__(self)
+        self.dps = 0
+        self.flbas = 0
+        self.nsze = 0x1400000
+        self.ncap = 0x1400000
+        self.setup_log_dir(self.__class__.__name__)
+        self.max_ns = self.get_max_ns()
+        self.ctrl_id = self.get_ctrl_id()
+        self.delete_all_ns()
+        time.sleep(1)
+
+    def __del__(self):
+        """
+        Post Section for TestNVMeAttachDetachNSCmd
+
+            - Create primary namespace.
+            - Atttach it to controller.
+            - Call super class's destructor.
+        """
+        assert_equal(self.create_and_validate_ns(self.default_nsid,
+                                                 self.nsze,
+                                                 self.ncap,
+                                                 self.flbas,
+                                                 self.dps), 0)
+        self.attach_ns(self.ctrl_id, self.default_nsid)
+        TestNVMe.__del__(self)
+
+    def test_attach_detach_ns(self):
+        """ Testcase main """
+        for nsid in range(1, self.max_ns):
+            print "##### Creating " + str(nsid)
+            err = self.create_and_validate_ns(nsid,
+                                              self.nsze,
+                                              self.ncap,
+                                              self.flbas,
+                                              self.dps)
+            assert_equal(err, 0)
+            print "##### Attaching " + str(nsid)
+            assert_equal(self.attach_ns(self.ctrl_id, nsid), 0)
+            print "##### Running IOs in " + str(nsid)
+            self.run_ns_io(nsid, 0)
+
+        for nsid in range(1, self.max_ns):
+            print "##### Detaching " + str(nsid)
+            assert_equal(self.detach_ns(self.ctrl_id, nsid), 0)
+            print "#### Deleting " + str(nsid)
+            assert_equal(self.delete_and_validate_ns(nsid), 0)
+        self.nvme_reset_ctrl()
diff --git a/tests/nvme_error_log_test.py b/tests/nvme_error_log_test.py
new file mode 100644
index 0000000..cedb24b
--- /dev/null
+++ b/tests/nvme_error_log_test.py
@@ -0,0 +1,86 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Smart Log Verification Testcase:-
+
+    1. Execute error-log on controller.
+    2. Execute error-log on each available namespace.
+
+"""
+
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+
+
+class TestNVMeErrorLogCmd(TestNVMe):
+
+    """
+    Represents Smart Log testcae.
+
+        - Attributes:
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeErrorLogCmd """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
+
+    def __del__(self):
+        """
+        Post Section for TestNVMeErrorLogCmd
+
+            - Call super class's destructor.
+        """
+        TestNVMe.__del__(self)
+
+    def get_error_log_ctrl(self):
+        """ Wrapper for executing error-log on controller.
+            - Args:
+                - None:
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        return self.get_error_log("0xFFFFFFFF")
+
+    def get_error_log_ns(self, nsid):
+        """ Wrapper for executing error-log on a namespace.
+            - Args:
+                - nsid: namespace id to be used in error-log command.
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        return self.get_error_log(nsid)
+
+    def get_error_log_all_ns(self):
+        """ Wrapper for executing error-log on all the namespaces.
+            - Args:
+                - None:
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        ns_list = self.get_ns_list()
+        for nsid in range(0, len(ns_list)):
+            self.get_error_log_ns(ns_list[nsid])
+        return 0
+
+    def test_get_error_log(self):
+        """ Testcase main """
+        assert_equal(self.get_error_log_ctrl(), 0)
+        assert_equal(self.get_error_log_all_ns(), 0)
diff --git a/tests/nvme_flush_test.py b/tests/nvme_flush_test.py
new file mode 100644
index 0000000..d080887
--- /dev/null
+++ b/tests/nvme_flush_test.py
@@ -0,0 +1,61 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Flush Command Testcase:-
+
+    1. Execute nvme flush on controller.
+
+"""
+
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+
+
+class TestNVMeFlushCmd(TestNVMe):
+
+    """
+    Represents Flush Testcase. Inherits TestNVMe class.
+
+        - Attributes:
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeFlushCmd """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
+
+    def __del__(self):
+        """ Post Section for TestNVMeFlushCmd """
+        TestNVMe.__del__(self)
+
+    def nvme_flush(self):
+        """ Wrapper for nvme flush command.
+           - Args:
+               - None
+           - Returns:
+               - None
+        """
+        flush_cmd = "nvme flush " + self.ctrl + " -n " + str(self.default_nsid)
+        print flush_cmd
+        return self.exec_cmd(flush_cmd)
+
+    def test_nvme_flush(self):
+        """ Testcase main """
+        assert_equal(self.nvme_flush(), 0)
diff --git a/tests/nvme_format_test.py b/tests/nvme_format_test.py
new file mode 100644
index 0000000..e5da23f
--- /dev/null
+++ b/tests/nvme_format_test.py
@@ -0,0 +1,145 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+Namespace Format testcase :-
+
+    1. Create, attach, detach, delete primary namespace and
+       extract the supported format information from default namespace:-
+           - List of the supported format.
+           - List of Metadata Size per format. Based on this we calculate
+             data protection parameter at the time of namespace.
+           - List of LBA Data Size per format.
+    2. Use the collected information and iterate through each supported
+       format:-
+           - Create namespace.
+           - Attach namespace.
+           - Run IOs on the namespace under test.
+           - Detach namespace
+           - Delete Namespace.
+"""
+
+import time
+import subprocess
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+
+
+class TestNVMeFormatCmd(TestNVMe):
+
+    """
+    Represents Format testcase.
+
+        - Attributes:
+              - dps : data protection information.
+              - flabs : LBA format information.
+              - nsze : namespace size.
+              - ncap : namespace capacity.
+              - ctrl_id : controller id.
+              - lba_format_list : lis of supported format.
+              - ms_list : list of metadat size per format.
+              - lbads_list : list of LBA data size per format.
+              - test_log_dir : directory for logs, temp files.
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeFormatCmd """
+        TestNVMe.__init__(self)
+        self.dps = 0                 # ns data protection settings
+        self.flbas = 0               # ns formattes logical block settings
+        self.nsze = 0x1400000        # ns size
+        self.ncap = 0x1400000        # ns capacity
+        self.ctrl_id = self.get_ctrl_id()
+        self.lba_format_list = []
+        self.ms_list = []
+        self.lbads_list = []
+        self.test_log_dir = self.log_dir + "/" + self.__class__.__name__
+        self.setup_log_dir(self.__class__.__name__)
+        self.delete_all_ns()
+        time.sleep(1)
+
+    def __del__(self):
+        """
+        Post Section for TestNVMeFormatCmd
+
+            - Create primary namespace.
+            - Atttach it to controller.
+            - Call super class's destructor.
+        """
+        assert_equal(self.create_and_validate_ns(self.default_nsid,
+                                                 self.nsze,
+                                                 self.ncap,
+                                                 self.flbas,
+                                                 self.dps), 0)
+        self.attach_ns(self.ctrl_id, self.default_nsid)
+        TestNVMe.__del__(self)
+
+    def attach_detach_primary_ns(self):
+        """ Extract supported format information using default namespace """
+        assert_equal(self.create_and_validate_ns(self.default_nsid,
+                                                 self.nsze,
+                                                 self.ncap,
+                                                 self.flbas,
+                                                 self.dps), 0)
+        assert_equal(self.attach_ns(self.ctrl_id, self.default_nsid), 0)
+        # read lbaf information
+        id_ns = "nvme id-ns " + self.ctrl + \
+                " -n1 | grep ^lbaf | awk '{print $2}' | tr -s \"\\n\" \" \""
+        proc = subprocess.Popen(id_ns, shell=True, stdout=subprocess.PIPE)
+        self.lba_format_list = proc.stdout.read().strip().split(" ")
+        if proc.wait() == 0:
+            # read lbads information
+            id_ns = "nvme id-ns " + self.ctrl + \
+                    " -n1 | grep ^lbaf | awk '{print $5}'" + \
+                    " | cut -f 2 -d ':' | tr -s \"\\n\" \" \""
+            proc = subprocess.Popen(id_ns, shell=True, stdout=subprocess.PIPE)
+            self.lbads_list = proc.stdout.read().strip().split(" ")
+            # read metadata information
+            id_ns = "nvme id-ns " + self.ctrl + \
+                    " -n1 | grep ^lbaf | awk '{print $4}'" + \
+                    " | cut -f 2 -d ':' | tr -s \"\\n\" \" \""
+            proc = subprocess.Popen(id_ns, shell=True, stdout=subprocess.PIPE)
+            self.ms_list = proc.stdout.read().strip().split(" ")
+            assert_equal(self.detach_ns(self.ctrl_id, self.default_nsid), 0)
+            assert_equal(self.delete_and_validate_ns(self.default_nsid), 0)
+            self.nvme_reset_ctrl()
+
+    def test_format_ns(self):
+        """ Testcase main """
+        # extract the supported format information.
+        self.attach_detach_primary_ns()
+
+        # iterate through all supported format
+        for i in range(0, len(self.lba_format_list)):
+            print "\nlba format " + str(self.lba_format_list[i]) + \
+                  " lbad       " + str(self.lbads_list[i]) + \
+                  " ms         " + str(self.ms_list[i])
+            metadata_size = 1 if self.ms_list[i] == '8' else 0
+            err = self.create_and_validate_ns(self.default_nsid,
+                                              self.nsze,
+                                              self.ncap,
+                                              self.lba_format_list[i],
+                                              metadata_size)
+            assert_equal(err, 0)
+            assert_equal(self.attach_ns(self.ctrl_id, self.default_nsid), 0)
+            self.run_ns_io(self.default_nsid, self.lbads_list[i])
+            time.sleep(5)
+            assert_equal(self.detach_ns(self.ctrl_id, self.default_nsid), 0)
+            assert_equal(self.delete_and_validate_ns(self.default_nsid), 0)
+            self.nvme_reset_ctrl()
diff --git a/tests/nvme_get_features_test.py b/tests/nvme_get_features_test.py
new file mode 100644
index 0000000..7511de9
--- /dev/null
+++ b/tests/nvme_get_features_test.py
@@ -0,0 +1,103 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+Get Features Testcase:-
+
+Test the Mandetory features with get features command:-
+    1. 01h rbitration.

Looks like a spelling mistake?

+    2. 02h M Power Management.
+    3. 04h M Temperature Threshold.
+    4. 05h M Error Recovery.
+    5. 07h M Number of Queues.
+    6. 08h M Interrupt Coalescing.
+    7. 09h M Interrupt Vector Configuration.
+    8. 0Ah M Write Atomicity Normal.
+    9. 0Bh M Asynchronous Event Configuration.
+"""
+
+import subprocess
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+
+
+class TestNVMeGetMandetoryFeatures(TestNVMe):
+
+    """
+    Represents Get Features testcase.
+
+        - Attributes:
+              - feature_id_list : list of the mandetory features.
+              - get_vector_list_cmd : vector list collection for 09h.
+              - vector_list : vector list to hold the interrupt vectors.
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeGetMandetoryFeatures """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
+        self.feature_id_list = ["0x01", "0x02", "0x04", "0x05", "0x07",
+                                "0x08", "0x09", "0x0A", "0x0B"]
+        get_vector_list_cmd = "cat /proc/interrupts | grep nvme |" \
+                              " cut -d : -f 1 | tr -d ' ' | tr '\n' ' '"
+        proc = subprocess.Popen(get_vector_list_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        self.vector_list = []
+        self.vector_list = proc.stdout.read().strip().split(" ")
+
+    def __del__(self):
+        """ Post Section for TestNVMeGetMandetoryFeatures
+
+            Call super class's destructor.
+        """
+        TestNVMe.__del__(self)
+
+    def get_mandetory_features(self, feature_id):
+        """ Wrapper for NVMe get features command
+            - Args:
+                - feature_id : feature id to be used with get feature command.
+            - Returns:
+                - None
+        """
+        if str(feature_id) == "0x09":
+            for vector in self.vector_list:
+                get_feat_cmd = "nvme get-feature " + self.ctrl + \
+                               " --feature-id=" + str(feature_id) + \
+                               " --cdw11=" + str(vector)
+                proc = subprocess.Popen(get_feat_cmd,
+                                        shell=True,
+                                        stdout=subprocess.PIPE)
+                feature_output = proc.communicate()[0]
+                print feature_output
+                assert_equal(proc.wait(), 0)
+        else:
+            get_feat_cmd = "nvme get-feature " + self.ctrl + \
+                           " --feature-id=" + str(feature_id)
+            proc = subprocess.Popen(get_feat_cmd,
+                                    shell=True,
+                                    stdout=subprocess.PIPE)
+            feature_output = proc.communicate()[0]
+            print feature_output
+            assert_equal(proc.wait(), 0)
+
+    def test_get_mandetory_features(self):
+        """ Testcase main """
+        for feature_id in self.feature_id_list:
+            self.get_mandetory_features(feature_id)
diff --git a/tests/nvme_read_write_test.py b/tests/nvme_read_write_test.py
new file mode 100644
index 0000000..a5f4579
--- /dev/null
+++ b/tests/nvme_read_write_test.py
@@ -0,0 +1,72 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Read/Write Testcae:-
+
+    1. Create data file with specific pattern outside of the device under test.
+    2. Write data file on the namespace under test.
+    3. Read the data from the namespace under test into different file.
+    4. Compare file in #1 and #3.
+"""
+
+import filecmp
+from nose.tools import assert_equal
+from nvme_test_io import TestNVMeIO
+
+
+class TestNVMeReadWriteTest(TestNVMeIO):
+
+    """
+    Represents NVMe read, write testcase.
+
+        - Attributes:
+              - start_block : starting block of to perform IO.
+              - compare_file : data file to use in nvme comapre commmand.
+              - test_log_dir : directory for logs, temp files.
+    """
+    def __init__(self):
+        """ Pre Section for TestNVMeReadWriteTest """
+        TestNVMeIO.__init__(self)
+        self.start_block = 1023
+        self.test_log_dir = self.log_dir + "/" + self.__class__.__name__
+        self.setup_log_dir(self.__class__.__name__)
+        self.write_file = self.test_log_dir + "/" + self.write_file
+        self.read_file = self.test_log_dir + "/" + self.read_file
+        self.create_data_file(self.write_file, self.data_size, "15")
+        open(self.read_file, 'a').close()
+
+    def __del__(self):
+        """ Post Section for TestNVMeReadWriteTest """
+        TestNVMeIO.__del__(self)
+
+    def read_validate(self):
+        """ Validate the data file read
+            - Args:
+                - None
+            - Returns:
+                - returns 0 on success, 1 on failure.
+        """
+        return 0 if filecmp.cmp(self.read_file, self.write_file) else 1
+
+    def test_nvme_write(self):
+        """ Testcaes main  """
+        assert_equal(self.nvme_write(), 0)
+        assert_equal(self.nvme_read(), 0)
+        assert_equal(self.read_validate(), 0)
diff --git a/tests/nvme_simple_template_test.py b/tests/nvme_simple_template_test.py
new file mode 100644
index 0000000..b6736da
--- /dev/null
+++ b/tests/nvme_simple_template_test.py
@@ -0,0 +1,55 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+""" Simple Template test example :-
+"""
+
+from nvme_test import TestNVMe
+
+
+class TestNVMeSimpleTestTemplate(TestNVMe):
+
+    """ Represents Simple NVMe test """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeSimpleTestTemplate. """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
+        # Add this test specific variables here
+
+    def __del__(self):
+        """ Post Section for TestNVMeSimpleTestTemplate
+
+            Call super class's destructor.
+        """
+        # Add this test specific cleanup code here
+        TestNVMe.__del__(self)
+
+    def simple_template_test(self):
+        """ Wrapper for this test specific functions
+            - Args:
+                - None
+            - Returns:
+                - None
+        """
+        pass
+
+    def test_get_mandetory_features(self):
+        """ Testcase main """
+        self.simple_template_test()
diff --git a/tests/nvme_smart_log_test.py b/tests/nvme_smart_log_test.py
new file mode 100644
index 0000000..e1eb6e5
--- /dev/null
+++ b/tests/nvme_smart_log_test.py
@@ -0,0 +1,86 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Smart Log Verification Testcase:-
+
+    1. Execute smat-log on controller.
+    2. Execute smart-log on each available namespace.
+
+"""
+
+from nose.tools import assert_equal
+from nvme_test import TestNVMe
+
+
+class TestNVMeSmartLogCmd(TestNVMe):
+
+    """
+    Represents Smart Log testcae.
+
+        - Attributes:
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeSmartLogCmd """
+        TestNVMe.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
+
+    def __del__(self):
+        """
+        Post Section for TestNVMeSmartLogCmd
+
+            - Call super class's destructor.
+        """
+        TestNVMe.__del__(self)
+
+    def get_smart_log_ctrl(self):
+        """ Wrapper for executing smart-log on controller.
+            - Args:
+                - None:
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        return self.get_smart_log("0xFFFFFFFF")
+
+    def get_smart_log_ns(self, nsid):
+        """ Wrapper for executing smart-log on a namespace.
+            - Args:
+                - nsid: namespace id to be used in smart-log command.
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        return self.get_smart_log(nsid)
+
+    def get_smart_log_all_ns(self):
+        """ Wrapper for executing smart-log on all the namespaces.
+            - Args:
+                - None:
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        ns_list = self.get_ns_list()
+        for nsid in range(0, len(ns_list)):
+            self.get_smart_log_ns(ns_list[nsid])
+        return 0
+
+    def test_smart_log(self):
+        """ Testcase main """
+        assert_equal(self.get_smart_log_ctrl(), 0)
+        assert_equal(self.get_smart_log_all_ns(), 0)
diff --git a/tests/nvme_test.py b/tests/nvme_test.py
new file mode 100644
index 0000000..c3ee16e
--- /dev/null
+++ b/tests/nvme_test.py
@@ -0,0 +1,395 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+""" Base class for all the testcases
+"""
+
+import re
+import os
+import sys
+import json
+import mmap
+import stat
+import time
+import shutil
+import string
+import subprocess
+from nose import tools
+from nose.tools import assert_equal
+from nvme_test_logger import TestNVMeLogger
+
+
+class TestNVMe(object):
+
+    """
+    Represents a testcase, each testcase shuold inherit this
+    class or appropriate subclass which is a child of this class.
+
+    Common utility functions used in various testcases.
+
+        - Attributes:
+            - ctrl : NVMe Controller.
+            - ns1 : default namespace.
+            - default_nsid : default namespace id.
+            - config_file : configuration file.
+            - clear_log_dir : default log directory.
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMe. """
+        # common code used in various testcases.
+        self.ctrl = "XXX"
+        self.ns1 = "XXX"
+        self.test_log_dir = "XXX"
+        self.default_nsid = 0x1
+        self.config_file = 'config.json'
+
+        self.load_config()
+        self.validate_pci_device()
+
+    def __del__(self):
+        """ Post Section for TestNVMe. """
+        if self.clear_log_dir is True:
+            shutil.rmtree(self.log_dir, ignore_errors=True)
+
+    @tools.nottest
+    def validate_pci_device(self):
+        """ Validate underlaying device belogs to pci subsystem.
+            - Args:
+                - None
+            - Returns:
+                - None
+        """
+        cmd = cmd = "find /sys/devices -name \\*nvme0 | grep -i pci"
+        err = subprocess.call(cmd, shell=True)
+        assert_equal(err, 0, "ERROR : Only NVMe PCI subsystem is supported")
+
+    @tools.nottest
+    def load_config(self):
+        """ Load Basic test configuration.
+            - Args:
+                - None
+            - Returns:
+                - None
+        """
+        with open(self.config_file) as data_file:
+            config = json.load(data_file)
+            self.ctrl = config['controller']
+            self.ns1 = config['ns1']
+            self.log_dir = config['log_dir']
+            self.clear_log_dir = False
+
+            if self.clear_log_dir is True:
+                shutil.rmtree(self.log_dir, ignore_errors=True)
+
+            if not os.path.exists(self.log_dir):
+                os.makedirs(self.log_dir)
+
+    @tools.nottest
+    def setup_log_dir(self, test_name):
+        """ Set up the log directory for a testcase
+            Args:
+              - test_name : name of the testcase.
+            Returns:
+              - None
+        """
+        self.test_log_dir = self.log_dir + "/" + test_name
+        if not os.path.exists(self.test_log_dir):
+            os.makedirs(self.test_log_dir)
+        sys.stdout = TestNVMeLogger(self.test_log_dir + "/" + "stdout.log")
+        sys.stderr = TestNVMeLogger(self.test_log_dir + "/" + "stderr.log")
+
+    @tools.nottest
+    def exec_cmd(self, cmd):
+        """ Wrapper for executing a shell command and return the result. """
+        proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        return proc.wait()
+
+    @tools.nottest
+    def nvme_reset_ctrl(self):
+        """ Wrapper for nvme reset command.
+            - Args:
+                - None:
+            - Returns:
+                - None
+        """
+        nvme_reset_cmd = "nvme reset " + self.ctrl
+        err = subprocess.call(nvme_reset_cmd,
+                              shell=True,
+                              stdout=subprocess.PIPE)
+        assert_equal(err, 0, "ERROR : nvme reset failed")
+        time.sleep(5)
+        rescan_cmd = "echo 1 > /sys/bus/pci/rescan"
+        proc = subprocess.Popen(rescan_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE,
+                                stderr=subprocess.PIPE)
+        time.sleep(5)
+        assert_equal(proc.wait(), 0, "ERROR : pci rescan failed")
+
+    @tools.nottest
+    def get_ctrl_id(self):
+        """ Wrapper for extracting the controller id.
+            - Args:
+                - None
+            - Returns:
+                - controller id.
+        """
+        get_ctrl_id = "nvme list-ctrl " + self.ctrl
+        proc = subprocess.Popen(get_ctrl_id,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : nvme list-ctrl failed")
+        line = proc.stdout.readline()
+        ctrl_id = line.split(":")[1].strip()
+        return ctrl_id
+
+    @tools.nottest
+    def get_ns_list(self):
+        """ Wrapper for extrating the namespace list.
+            - Args:
+                - None
+            - Returns:
+                - List of the namespaces.
+        """
+        ns_list = []
+        ns_list_cmd = "nvme list-ns " + self.ctrl
+        proc = subprocess.Popen(ns_list_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        assert_equal(proc.wait(), 0, "ERROR : nvme list namespace failed")
+        for line in proc.stdout:
+            ns_list.append(string.replace(line.split(":")[1], '\n', ''))
+
+        return ns_list
+
+    @tools.nottest
+    def get_max_ns(self):
+        """ Wrapper for extracting maximum number of namspaces supported.
+            - Args:
+                - None
+            - Returns:
+                - maximum number of namespaces supported.
+        """
+        pattern = re.compile("^nn[ ]+: [0-9]", re.IGNORECASE)
+        max_ns = -1
+        max_ns_cmd = "nvme id-ctrl " + self.ctrl
+        proc = subprocess.Popen(max_ns_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : reading maximum namespace count failed")
+
+        for line in proc.stdout:
+            if pattern.match(line):
+                max_ns = line.split(":")[1].strip()
+                break
+        print max_ns
+        return int(max_ns)
+
+    @tools.nottest
+    def delete_all_ns(self):
+        """ Wrapper for deleting all the namespaces.
+            - Args:
+                - None
+            - Returns:
+                - None
+        """
+        delete_ns_cmd = "nvme delete-ns " + self.ctrl + " -n 0xFFFFFFFF"
+        assert_equal(self.exec_cmd(delete_ns_cmd), 0)
+        list_ns_cmd = "nvme list-ns " + self.ctrl + " --all | wc -l"
+        proc = subprocess.Popen(list_ns_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        output = proc.stdout.read().strip()
+        assert_equal(output, '0', "ERROR : deleting all namespace failed")
+
+    @tools.nottest
+    def create_ns(self, nsze, ncap, flbas, dps):
+        """ Wrapper for creating a namespace.
+            - Args:
+                - nsze : new namespace size.
+                - ncap : new namespace capacity.
+                - flbas : new namespace format.
+                - dps : new namespace data protection information.
+            - Returns:
+                - return code of the nvme create namespace command.
+        """
+        create_ns_cmd = "nvme create-ns " + self.ctrl + " --nsze=" + \
+                        str(nsze) + " --ncap=" + str(ncap) + \
+                        " --flbas=" + str(flbas) + " --dps=" + str(dps)
+        return self.exec_cmd(create_ns_cmd)
+
+    @tools.nottest
+    def create_and_validate_ns(self, nsid, nsze, ncap, flbas, dps):
+        """ Wrapper for creating and validating a namespace.
+            - Args:
+                - nsid : new namespace id.
+                - nsze : new namespace size.
+                - ncap : new namespace capacity.
+                - flbas : new namespace format.
+                - dps : new namespace data protection information.
+            - Returns:
+                - return 0 on success, error code on failure.
+        """
+        err = self.create_ns(nsze, ncap, flbas, dps)
+        if err == 0:
+            time.sleep(2)
+            id_ns_cmd = "nvme id-ns " + self.ctrl + " -n " + str(nsid)
+            err = subprocess.call(id_ns_cmd,
+                                  shell=True,
+                                  stdout=subprocess.PIPE)
+        return err
+
+    @tools.nottest
+    def attach_ns(self, ctrl_id, ns_id):
+        """ Wrapper for attaching the namespace.
+            - Args:
+                - ctrl_id : controller id to which namespace to be attched.
+                - nsid : new namespace id.
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        attach_ns_cmd = "nvme attach-ns " + self.ctrl + \
+                        " --namespace-id=" + str(ns_id) + \
+                        " --controllers=" + ctrl_id
+        err = subprocess.call(attach_ns_cmd,
+                              shell=True,
+                              stdout=subprocess.PIPE)
+        time.sleep(5)
+        if err == 0:
+            # enumerate new namespace block device
+            self.nvme_reset_ctrl()
+            time.sleep(5)
+            # check if new namespace block device exists
+            err = 0 if stat.S_ISBLK(os.stat(self.ns1).st_mode) else 1
+        return err
+
+    @tools.nottest
+    def detach_ns(self, ctrl_id, nsid):
+        """ Wrapper for detaching the namespace.
+            - Args:
+                - ctrl_id : controller id to which namespace to be attched.
+                - nsid : new namespace id.
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        detach_ns_cmd = "nvme detach-ns " + self.ctrl + \
+                        " --namespace-id=" + str(nsid) + \
+                        " --controllers=" + ctrl_id
+        return subprocess.call(detach_ns_cmd,
+                               shell=True,
+                               stdout=subprocess.PIPE)
+
+    @tools.nottest
+    def delete_and_validate_ns(self, nsid):
+        """ Wrapper for deleting and validating that namespace is deleted.
+            - Args:
+                - nsid : new namespace id.
+            - Returns:
+                - 0 on success, 1 on failure.
+        """
+        # delete the namespace
+        delete_ns_cmd = "nvme delete-ns " + self.ctrl + " -n " + str(nsid)
+        err = subprocess.call(delete_ns_cmd,
+                              shell=True,
+                              stdout=subprocess.PIPE)
+        assert_equal(err, 0, "ERROR : delete namespace failed")
+        return err
+
+    def get_smart_log(self, nsid):
+        """ Wrapper for nvme smart-log command.
+            - Args:
+                - nsid : namespace id to get smart log from.
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        smart_log_cmd = "nvme smart-log " + self.ctrl + " -n " + str(nsid)
+        print smart_log_cmd
+        proc = subprocess.Popen(smart_log_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : nvme smart log failed")
+
+        for line in proc.stdout:
+            if "data_units_read" in line:
+                data_units_read = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+            if "data_units_written" in line:
+                data_units_written = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+            if "host_read_commands" in line:
+                host_read_commands = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+            if "host_write_commands" in line:
+                host_write_commands = \
+                    string.replace(line.split(":")[1].strip(), ",", "")
+
+        print "data_units_read " + data_units_read
+        print "data_units_written " + data_units_written
+        print "host_read_commands " + host_read_commands
+        print "host_write_commands " + host_write_commands
+        return err
+
+    def get_error_log(self, nsid):
+        """ Wrapper for nvme error-log command.
+            - Args:
+                - nsid : namespace id to get error log from.
+            - Returns:
+                - 0 on success, error code on failure.
+        """
+        pattern = re.compile("^ Entry\[[ ]*[0-9]+\]")
+        error_log_cmd = "nvme error-log " + self.ctrl + " -n " + str(nsid)
+        proc = subprocess.Popen(error_log_cmd,
+                                shell=True,
+                                stdout=subprocess.PIPE)
+        err = proc.wait()
+        assert_equal(err, 0, "ERROR : nvme error log failed")
+        line = proc.stdout.readline()
+        err_log_entry_count = int(line.split(" ")[5].strip().split(":")[1])
+        entry_count = 0
+        for line in proc.stdout:
+            if pattern.match(line):
+                entry_count += 1
+
+        return 0 if err_log_entry_count == entry_count else 1
+
+    def run_ns_io(self, nsid, lbads):
+        """ Wrapper to run ios on namespace under test.
+            - Args:
+                - lbads : LBA Data size supported in power of 2 format.
+            - Returns:
+                - None
+        """
+        block_size = mmap.PAGESIZE if lbads < 9 else 2 ** int(lbads)
+        ns_path = self.ctrl + "n" + str(nsid)
+        io_cmd = "dd if=" + ns_path + " of=/dev/null" + " bs=" + \
+                 str(block_size) + " count=10 > /dev/null 2>&1"
+        print io_cmd
+        run_io = subprocess.Popen(io_cmd, shell=True, stdout=subprocess.PIPE)
+        run_io_result = run_io.communicate()[1]
+        assert_equal(run_io_result, None)
+        io_cmd = "dd if=/dev/zero of=" + ns_path + " bs=" + \
+                 str(block_size) + " count=10 > /dev/null 2>&1"
+        print io_cmd
+        run_io = subprocess.Popen(io_cmd, shell=True, stdout=subprocess.PIPE)
+        run_io_result = run_io.communicate()[1]
+        assert_equal(run_io_result, None)
diff --git a/tests/nvme_test_io.py b/tests/nvme_test_io.py
new file mode 100644
index 0000000..e2a6b46
--- /dev/null
+++ b/tests/nvme_test_io.py
@@ -0,0 +1,99 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+""" Inherit TestNVMeIO for nvme read/write operations """
+
+import os
+from nose import tools
+from nvme_test import TestNVMe
+
+
+class TestNVMeIO(TestNVMe):
+
+    """
+    Variable and Methods required to perform nvme read/write.
+
+        - Attributes:
+              - data_size : data size to perform IO.
+              - start_block : starting block of to perform IO.
+              - block_count : Number of blocks to use in IO.
+              - write_file : data file to use in nvme write command.
+              - read_file : data file to use in nvme read command.
+    """
+
+    def __init__(self):
+        """ Pre Section for TestNVMeIO """
+        TestNVMe.__init__(self)
+        # common code used in various testcases.
+        self.data_size = 512
+        self.start_block = 0
+        self.block_count = 0
+        self.write_file = "write_file.txt"
+        self.read_file = "read_file.txt"
+
+    def __del__(self):
+        """ Post Section for TestNVMeIO """
+        TestNVMe.__del__(self)
+
+    @tools.nottest
+    def create_data_file(self, pathname, data_size, pattern):
+        """ Creates data file with specific pattern
+            - Args:
+                - pathname : data file path name.
+                - data_size : total size of the data.
+                - pattern : data pattern to create file.
+            - Returns:
+            None
+        """
+        pattern_len = len(pattern)
+        data_file = open(pathname, "w")
+        for i in range(0, data_size):
+            data_file.write(pattern[i % pattern_len])
+        data_file.flush()
+        os.fsync(data_file.fileno())
+        data_file.close()
+
+    @tools.nottest
+    def nvme_write(self):
+        """ Wrapper for nvme write operation
+            - Args:
+                - None
+            - Returns:
+                - return code for nvme write command.
+        """
+        write_cmd = "nvme write " + self.ns1 + " --start-block=" + \
+                    str(self.start_block) + " --block-count=" + \
+                    str(self.block_count) + " --data-size=" + \
+                    str(self.data_size) + " --data=" + self.write_file
+        return self.exec_cmd(write_cmd)
+
+    @tools.nottest
+    def nvme_read(self):
+        """ Wrapper for nvme read operation
+            - Args:
+                - None
+            - Returns:
+                - return code for nvme read command.
+        """
+        read_cmd = "nvme read " + self.ns1 + " --start-block=" + \
+                   str(self.start_block) + " --block-count=" + \
+                   str(self.block_count) + " --data-size=" + \
+                   str(self.data_size) + " --data=" + self.read_file
+        print read_cmd
+        return self.exec_cmd(read_cmd)
diff --git a/tests/nvme_test_logger.py b/tests/nvme_test_logger.py
new file mode 100644
index 0000000..c59fa18
--- /dev/null
+++ b/tests/nvme_test_logger.py
@@ -0,0 +1,52 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+Logger for NVMe Test Framwwork:-
+
+"""
+import sys
+
+
+class TestNVMeLogger(object):
+    """ Represents Logger for NVMe Testframework.  """
+    def __init__(self, log_file_path):
+        """ Logger setup
+            - Args:
+                log_file_path : path to store the log.
+        """
+        self.terminal = sys.stdout
+        self.log = open(log_file_path, "w")
+
+    def write(self, log_message):
+        """ Logger setup
+            - Args:
+                log_message: string to write in the log file.
+            - Returns:
+                None
+        """
+        self.terminal.write(log_message)
+        self.log.write(log_message)
+
+    def flush(self):
+        """ This flush method is needed for python 3 compatibility.
+            this handles the flush command by doing nothing.
+            you might want to specify some extra behavior here.
+        """
+        pass
diff --git a/tests/nvme_writeuncor_test.py b/tests/nvme_writeuncor_test.py
new file mode 100644
index 0000000..9f96f63
--- /dev/null
+++ b/tests/nvme_writeuncor_test.py
@@ -0,0 +1,76 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Write Compare Testcae:-
+
+    1. Read block of data successfully.
+    2. Issue write uncorrectable to block of data.
+    3. Attempt to read from same block; shall fail.
+    4. Issue a write command to first block of data.
+    5. Read from the same block; shall pass.
+
+"""
+
+from nose.tools import assert_equal, assert_not_equal
+from nvme_test_io import TestNVMeIO
+
+
+class TestNVMeUncor(TestNVMeIO):
+
+    """
+    Represents NVMe Write Uncorrecatble testcase.
+        - Attributes:
+              - start_block : starting block of to perform IO.
+              - test_log_dir : directory for logs, temp files.
+    """
+
+    def __init__(self):
+        """ Constructor TestNVMeUncor """
+        TestNVMeIO.__init__(self)
+        self.start_block = 1023
+        self.setup_log_dir(self.__class__.__name__)
+        self.write_file = self.test_log_dir + "/" + self.write_file
+        self.read_file = self.test_log_dir + "/" + self.read_file
+        self.create_data_file(self.write_file, self.data_size, "15")
+        open(self.read_file, 'a').close()
+
+    def __del__(self):
+        """ Post Section for TestNVMeUncor """
+        TestNVMeIO.__del__(self)
+
+    def write_uncor(self):
+        """ Wrapper for nvme write uncorrectable
+            - Args:
+                - None
+            - Returns:
+                - return code of nvme write uncorrectable command.
+        """
+        write_uncor_cmd = "nvme write-uncor " + self.ns1 + \
+                          " --start-block=" + str(self.start_block) + \
+                          " --block-count=" + str(self.block_count)
+        return self.exec_cmd(write_uncor_cmd)
+
+    def test_write_uncor(self):
+        """ Testcase main """
+        assert_equal(self.nvme_read(), 0)
+        assert_equal(self.write_uncor(), 0)
+        assert_not_equal(self.nvme_read(), 0)
+        assert_equal(self.nvme_write(), 0)
+        assert_equal(self.nvme_read(), 0)
diff --git a/tests/nvme_writezeros_test.py b/tests/nvme_writezeros_test.py
new file mode 100644
index 0000000..157fd78
--- /dev/null
+++ b/tests/nvme_writezeros_test.py
@@ -0,0 +1,102 @@
+# Copyright (c) 2015-2016 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
+#
+"""
+NVMe Write Zeros:-
+
+    1. Issue a write command to block of data.
+    2. Read from same block to verify data pattern.
+    3. Issue write zeros to the block of data.
+    4. Read from same block, should be all zeroes.
+
+"""
+
+import filecmp
+from nose.tools import assert_equal
+from nvme_test_io import TestNVMeIO
+
+
+class TestNVMeWriteZeros(TestNVMeIO):
+
+    """
+    Represents NVMe Write Zero Testcase.
+
+        - Attributes:
+              - zero_file : file with all '\0' to compare the zero data.
+              - data_size : data size to perform IO.
+              - start_block : starting block of to perform IO.
+              - block_count: Number of blocks to use in IO.
+              - test_log_dir : directory for logs, temp files.
+    """
+    def __init__(self):
+        """ Pre Section for TestNVMeWriteZeros """
+        TestNVMeIO.__init__(self)
+        self.start_block = 1023
+        self.block_count = 0
+        self.setup_log_dir(self.__class__.__name__)
+        self.write_file = self.test_log_dir + "/" + self.write_file
+        self.read_file = self.test_log_dir + "/" + self.read_file
+        self.zero_file = self.test_log_dir + "/" + "zero_file.txt"
+        self.create_data_file(self.write_file, self.data_size, "15")
+        self.create_data_file(self.zero_file, self.data_size, '\0')
+        open(self.read_file, 'a').close()
+
+    def __del__(self):
+        """ Post Section for TestNVMeWriteZeros """
+        TestNVMeIO.__del__(self)
+
+    def write_zeroes(self):
+        """ Wrapper for nvme write-zeroe
+            - Args:
+                - None
+            - Returns:
+                - return code for nvme write command.
+        """
+        write_zeroes_cmd = "nvme write-zeroes " + self.ns1 + \
+                           " --start-block=" + str(self.start_block) + \
+                           " --block-count=" + str(self.block_count)
+        return self.exec_cmd(write_zeroes_cmd)
+
+    def validate_write_read(self):
+        """ Validate the file which had been read from the device
+            - Args:
+                - None
+            - Returns:
+                - 0 on success, 1 on failure
+        """
+        return 0 if filecmp.cmp(self.write_file, self.read_file) is True else 1
+
+    def validate_zeroes(self):
+        """
+        Validate the data which is zeroed out via write-zeroes
+            - Args:
+                - None
+            - Returns:
+                - 0 on success, 1 on failure
+         """
+        return 0 if filecmp.cmp(self.zero_file, self.read_file) is True else 1
+
+    def test_write_zeros(self):
+        """ Testcae main """
+        assert_equal(self.nvme_write(), 0)
+        assert_equal(self.nvme_read(), 0)
+        assert_equal(self.validate_write_read(), 0)
+        assert_equal(self.write_zeroes(), 0)
+        assert_equal(self.nvme_read(), 0)
+        assert_equal(self.validate_zeroes(), 0)
--
1.9.1
